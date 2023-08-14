import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'package:freedesktop_desktop_entry/src/icon_theme_key.dart';
import 'package:freedesktop_desktop_entry/src/utils.dart';
import 'package:path/path.dart' as path;

import 'entry.dart';

class FreedesktopIconThemes {
  List<Directory> _baseDirectories = [];
  Map<String, DateTime> _baseDirectoriesLastChangedTimes = {};
  Map<String, _IconTheme> _iconThemes = {};
  Map<String, File> _fallbackIcons = {};
  Map<IconQuery, File?> _cachedMappings = {};
  DateTime _lastIconLookup = DateTime(0);

  FreedesktopIconThemes();

  FreedesktopIconThemes._new(
    this._baseDirectories,
    this._baseDirectoriesLastChangedTimes,
    this._iconThemes,
    this._fallbackIcons,
    this._cachedMappings,
  );

  Future<void> loadThemes() async {
    FreedesktopIconThemes themes = await Isolate.run(_index);
    _baseDirectories = themes._baseDirectories;
    _baseDirectoriesLastChangedTimes = themes._baseDirectoriesLastChangedTimes;
    _iconThemes = themes._iconThemes;
    _fallbackIcons = themes._fallbackIcons;
    _cachedMappings = themes._cachedMappings;
  }

  Future<File?> findIcon(IconQuery query) async {
    if (DateTime.now().difference(_lastIconLookup).inSeconds > 5) {
      var baseDirectories = await whereExists(getIconBaseDirectories().map(Directory.new)).toList();
      var modifiedTimes = await _getBaseDirectoriesChangedTimes(baseDirectories);

      if (!MapEquality().equals(modifiedTimes, _baseDirectoriesLastChangedTimes)) {
        await loadThemes();
      }
    }

    _lastIconLookup = DateTime.now();

    if (_cachedMappings.containsKey(query)) {
      return _cachedMappings[query];
    }

    // I don't know if environment variables can be used in absolute icon paths, but let's handle them just in case.
    bool isAbsolutePath = expandEnvironmentVariables(query.name).startsWith('/');

    File? icon;
    if (isAbsolutePath) {
      icon = File(query.name);
    } else {
      icon = _findIcon(query);
    }
    _cachedMappings[query] = icon;

    return icon;
  }

  File? _findIcon(IconQuery query) {
    File? file = _findIconFromThemes(query);
    if (file != null) {
      return file;
    }
    return _lookupFallbackIcon(query.name, query.extensions);
  }

  File? _findIconFromThemes(IconQuery query) {
    Set<_IconTheme> leafThemes = {};
    leafThemes.addAll(_iconThemes.values);
    for (_IconTheme theme in _iconThemes.values) {
      leafThemes.removeWhere((_IconTheme t) => theme.parents.contains(t));
    }

    var themes = query.preferredThemes.map((String theme) => _iconThemes[theme]).whereNotNull().toSet();
    themes.addAll(leafThemes);

    Set<String> visitedThemes = {};
    for (_IconTheme theme in themes) {
      File? file = _findIconHelper(theme, query.name, query.size, query.scale, query.extensions, visitedThemes);
      if (file != null) {
        return file;
      }
    }
    return null;
  }

  File? _findIconHelper(
    _IconTheme theme,
    String icon,
    int size,
    int scale,
    List<String> extensions,
    Set<String> visitedThemes,
  ) {
    for (_IconTheme theme in _visitIconThemeHierarchy(theme)) {
      File? file = _lookupIcon(theme, icon, size, scale, extensions);
      if (file != null) {
        return file;
      }
    }
    return null;
  }

  Iterable<_IconTheme> _visitIconThemeHierarchy(_IconTheme theme) sync* {
    Set<_IconTheme> visitedThemes = {};

    Iterable<_IconTheme> visit(_IconTheme theme) sync* {
      yield theme;
      visitedThemes.add(theme);

      for (_IconTheme parent in theme.parents) {
        if (!visitedThemes.contains(parent)) {
          yield* visit(parent);
        }
      }
    }

    yield* visit(theme);
  }

  File? _lookupIcon(
    _IconTheme theme,
    String iconName,
    int size,
    int scale,
    List<String> extensions,
  ) {
    for (String extension in extensions) {
      String filename = "$iconName.$extension";
      List<(String, _IconDirectoryDescription)>? iconDirs = theme.icons[filename];
      if (iconDirs == null) {
        continue;
      }
      for (var (String iconDirPath, _IconDirectoryDescription iconDir) in iconDirs) {
        if (!_directoryMatchesSize(iconDir, size, scale)) {
          continue;
        }
        return File(path.join(iconDirPath, '$iconName.$extension'));
      }
    }

    int? minimalSizeDistance;
    File? closestFile;

    for (String extension in extensions) {
      String filename = "$iconName.$extension";
      List<(String, _IconDirectoryDescription)>? iconDirs = theme.icons[filename];
      if (iconDirs == null) {
        continue;
      }
      for (var (String iconDirPath, _IconDirectoryDescription iconDir) in iconDirs) {
        final sizeDistance = _directorySizeDistance(iconDir, size, scale);
        if (minimalSizeDistance != null && sizeDistance >= minimalSizeDistance) {
          continue;
        }
        minimalSizeDistance = sizeDistance;
        closestFile = File(path.join(iconDirPath, '$iconName.$extension'));
      }
    }
    return closestFile;
  }

  bool _directoryMatchesSize(_IconDirectoryDescription dir, int iconSize, int iconScale) {
    if (dir.scale != iconScale) {
      return false;
    }
    switch (dir.type) {
      case _IconType.fixed:
        return dir.size == iconSize;
      case _IconType.scaled:
        return dir.minSize <= iconSize && iconSize <= dir.maxSize;
      case _IconType.threshold:
        return dir.size - dir.threshold <= iconSize && iconSize <= dir.size + dir.threshold;
    }
  }

  File? _lookupFallbackIcon(String iconName, List<String> extensions) {
    for (String extension in extensions) {
      String filename = "$iconName.$extension";
      File? icon = _fallbackIcons[filename];
      if (icon != null) {
        return icon;
      }
    }
    return null;
  }
}

Future<FreedesktopIconThemes> _index() async {
  final baseDirectories = await whereExists(getIconBaseDirectories().map(Directory.new)).toList();
  final baseDirectoriesLastChangedTimes = _getBaseDirectoriesChangedTimes(baseDirectories);
  Map<Directory, List<FileSystemEntity>> baseDirectoryContents = await _getBaseDirectoryContents(baseDirectories);

  // Some of these directories might not belong at all to a theme.
  List<Directory> iconThemeDirectories = baseDirectoryContents.values.flattened.whereType<Directory>().toList();
  final iconThemes = _parseIconThemes(iconThemeDirectories);
  final iconsIndexed = iconThemes.then((iconThemes) async {
    iconThemeDirectories = _getIconThemeDirectories(iconThemeDirectories, iconThemes).toList();
    await _indexIconThemeIcons(iconThemeDirectories, iconThemes);
  });

  final fallbackIcons = _indexFallbackIcons(baseDirectoryContents);

  Map<IconQuery, File?> cachedMappings = {};

  await iconsIndexed;

  return FreedesktopIconThemes._new(
    baseDirectories,
    await baseDirectoriesLastChangedTimes,
    await iconThemes,
    fallbackIcons,
    cachedMappings,
  );
}

Future<void> _indexIconThemeIcons(List<Directory> iconThemeDirectories, Map<String, _IconTheme> themes) async {
  for (Directory themeDir in iconThemeDirectories) {
    String themeName = path.basename(themeDir.absolute.path);
    _IconTheme theme = themes[themeName]!;

    final files = themeDir.list(recursive: true).where((entity) => entity is File).map((event) => event as File);
    await for (File file in files) {
      String longIconDirectory = path.dirname(file.path);
      String iconDirectory = path.normalize(path.relative(longIconDirectory, from: themeDir.path));

      _IconDirectoryDescription? iconDirectoryDescription = theme.iconDirectoryDescriptions[iconDirectory];

      if (iconDirectoryDescription == null) {
        continue;
      }

      String iconFileName = path.basename(file.path);
      theme.icons.putIfAbsent(iconFileName, () => []).add((path.absolute(longIconDirectory), iconDirectoryDescription));
    }
  }
}

Future<Map<String, DateTime>> _getBaseDirectoriesChangedTimes(Iterable<Directory> baseDirectories) async {
  return Map.fromEntries(await baseDirectories.map((dir) async {
    var stat = await dir.stat();
    return MapEntry(dir.absolute.path, stat.changed);
  }).wait);
}

Future<Map<Directory, List<FileSystemEntity>>> _getBaseDirectoryContents(Iterable<Directory> baseDirectories) async {
  return Map.fromEntries(await baseDirectories.map((Directory dir) async {
    return MapEntry(dir, await dir.list().toList());
  }).wait);
}

Map<String, File> _indexFallbackIcons(Map<Directory, List<FileSystemEntity>> baseDirectoryContents) {
  final Map<String, File> fallbackIcons = {};
  Iterable<File> baseIconDirectoryFiles = baseDirectoryContents.values.flattened.whereType<File>();
  for (File file in baseIconDirectoryFiles) {
    fallbackIcons.putIfAbsent(path.basename(file.path), () => file);
  }
  return fallbackIcons;
}

Future<Map<String, _IconTheme>> _parseIconThemes(Iterable<Directory> iconThemeDirectories) async {
  final Map<String, _IconThemeDescription> themeIndices = {};
  final List<Future<_IconThemeDescription?>> iconThemeDescriptions = [];

  for (Directory themeDir in iconThemeDirectories) {
    String themeName = path.basename(themeDir.absolute.path);
    if (themeIndices.containsKey(themeName)) {
      continue;
    }
    final iconThemeDescription = _parseIconThemeDescription(themeDir.absolute.path);
    iconThemeDescriptions.add(iconThemeDescription);
  }

  for (var iconThemeDescription in await iconThemeDescriptions.wait) {
    if (iconThemeDescription != null) {
      themeIndices[iconThemeDescription.name] = iconThemeDescription;
    }
  }

  final Map<String, _IconTheme> themes = themeIndices.map(
    (name, themeDescription) => MapEntry(
      name,
      _IconTheme(
        name: name,
        iconDirectoryDescriptions: themeDescription.iconDirectoryDescriptions,
      ),
    ),
  );

  // Establish links between themes.
  themes.forEach((name, theme) {
    theme.parents = themeIndices[name]!.parents.map((parent) => themes[parent]).whereNotNull().toList();
  });

  return themes;
}

Iterable<Directory> _getIconThemeDirectories(
  Iterable<Directory> iconThemeDirectories,
  Map<String, _IconTheme> themes,
) {
  // Filter out directories that don't belong to any theme.
  return iconThemeDirectories.where((themeDir) {
    String themeName = path.basename(themeDir.absolute.path);
    return themes.containsKey(themeName);
  });
}

class IconQuery extends Equatable {
  final String name;
  final int size;
  final int scale;
  final List<String> extensions;
  final List<String> preferredThemes;

  IconQuery({
    required this.name,
    required this.size,
    this.scale = 1,
    required this.extensions,
    this.preferredThemes = const [],
  });

  @override
  List<Object?> get props => [name, size, scale, extensions];
}

class _IconThemeDescription extends Equatable {
  final String name;
  final List<String> parents;
  final Map<String, _IconDirectoryDescription> iconDirectoryDescriptions;

  _IconThemeDescription({
    required this.name,
    required this.parents,
    required this.iconDirectoryDescriptions,
  });

  @override
  List<Object?> get props => [name];
}

class _IconTheme {
  final String name;
  List<_IconTheme> parents = [];
  final Map<String, _IconDirectoryDescription> iconDirectoryDescriptions;

  // Map<icon file name, List<(icon dir path, icon dir descriptor)>>
  final Map<String, List<(String, _IconDirectoryDescription)>> icons = {};

  _IconTheme({
    required this.name,
    required this.iconDirectoryDescriptions,
  });
}

enum _IconType {
  fixed('Fixed'),
  scaled('Scaled'),
  threshold('Threshold');

  final String string;

  const _IconType(this.string);
}

class _IconDirectoryDescription extends Equatable {
  final String name;
  final int size;
  final _IconType type;
  final int scale;
  final int minSize;
  final int maxSize;
  final int threshold;

  _IconDirectoryDescription({
    required this.name,
    required this.size,
    _IconType? type,
    int? scale,
    int? minSize,
    int? maxSize,
    int? threshold,
  })  : type = type ?? _IconType.threshold,
        scale = scale ?? 1,
        minSize = minSize ?? size,
        maxSize = maxSize ?? size,
        threshold = threshold ?? 2;

  @override
  List<Object?> get props => [name, size, type, scale, minSize, maxSize, threshold];
}

int _directorySizeDistance(_IconDirectoryDescription dir, int iconSize, int iconScale) {
  switch (dir.type) {
    case _IconType.fixed:
      return (dir.size * dir.scale - iconSize * iconScale).abs();
    case _IconType.scaled:
      if (iconSize * iconScale < dir.minSize * dir.scale) {
        return dir.minSize * dir.scale - iconSize * iconScale;
      }
      if (iconSize * iconScale > dir.maxSize * dir.scale) {
        return iconSize * iconScale - dir.maxSize * dir.scale;
      }
      return 0;
    case _IconType.threshold:
      if (iconSize * iconScale < (dir.size - dir.threshold) * dir.scale) {
        return dir.minSize * dir.scale - iconSize * iconScale;
      }
      if (iconSize * iconScale > (dir.size + dir.threshold) * dir.scale) {
        return iconSize * iconScale - dir.maxSize * dir.scale;
      }
      return 0;
  }
}

Future<_IconThemeDescription?> _parseIconThemeDescription(String themeDirectoryPath) async {
  try {
    final indexFile = File(path.join(themeDirectoryPath, "index.theme"));
    final sections = parseSections(await indexFile.readAsString());
    final entries = sections['Icon Theme']!;

    Map<String, _IconDirectoryDescription> iconDirectoryDescriptions = {};
    List<String> iconDirs = entries[IconThemeKey.directories.string]!.value.getStringList(',');

    for (String iconDir in iconDirs) {
      Map<String, Entry>? entries = sections[iconDir];
      if (entries == null) {
        continue;
      }
      try {
        String? type = entries[IconThemeKey.type.string]?.value;

        iconDirectoryDescriptions[iconDir] = _IconDirectoryDescription(
          name: iconDir,
          size: entries[IconThemeKey.size.string]!.value.getInteger()!,
          type: _IconType.values.firstWhereOrNull((e) => e.string == type),
          scale: entries[IconThemeKey.scale.string]?.value.getInteger(),
          minSize: entries[IconThemeKey.minSize.string]?.value.getInteger(),
          maxSize: entries[IconThemeKey.maxSize.string]?.value.getInteger(),
          threshold: entries[IconThemeKey.threshold.string]?.value.getInteger(),
        );
      } catch (_) {
        continue;
      }
    }

    List<String> parents = entries[IconThemeKey.inherits.string]?.value.getStringList(',') ?? [];
    String themeName = path.basename(themeDirectoryPath);
    if (themeName != 'hicolor' && !parents.contains('hicolor')) {
      // hicolor must always be in the inheritance tree.
      parents.add('hicolor');
    }

    final iconTheme = _IconThemeDescription(
      name: themeName,
      parents: parents,
      iconDirectoryDescriptions: iconDirectoryDescriptions,
    );

    return iconTheme;
  } catch (_) {
    return null;
  }
}

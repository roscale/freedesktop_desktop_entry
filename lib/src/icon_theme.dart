import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'package:freedesktop_desktop_entry/src/icon_theme_key.dart';
import 'package:freedesktop_desktop_entry/src/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;

import 'entry.dart';

part 'icon_theme.freezed.dart';

class FreedesktopIconTheme {
  FreedesktopIconTheme._(this._iconTheme);

  final _IconTheme _iconTheme;

  final Map<_IconQuery, File?> _cachedMappings = {};

  static Future<FreedesktopIconTheme> load(String theme) async {
    return FreedesktopIconTheme._(await _IconTheme.load(theme));
  }

  File? findIcon({
    required String name,
    required int size,
    int scale = 1,
    // A combination of 'png', 'svg', and 'xpm'.
    required Set<String> extensions,
  }) {
    final query = _IconQuery(
      name: name,
      size: size,
      scale: scale,
      extensions: extensions,
    );
    if (_cachedMappings.containsKey(query)) {
      return _cachedMappings[query];
    }

    // I don't know if environment variables can be used here, but let's handle them just in case.
    bool isAbsolutePath = expandEnvironmentVariables(name).startsWith('/');

    File? icon;
    if (isAbsolutePath) {
      icon = File(name);
    } else {
      icon = _iconTheme._findIcon(name, size, scale, extensions);
    }
    _cachedMappings[query] = icon;

    return icon;
  }
}

class _IconQuery extends Equatable {
  final String name;
  final int size;
  final int scale;
  final Set<String> extensions;

  _IconQuery({
    required this.name,
    required this.size,
    required this.scale,
    required this.extensions,
  });

  @override
  List<Object?> get props => [name, size, scale, extensions];
}

@freezed
class _IconTheme with _$_IconTheme {
  const _IconTheme._();

  const factory _IconTheme({
    required String name,

    /// Entries from `[Icon Theme]`.
    required Map<String, Entry> entries,
    @Default([]) List<_IconTheme> parents,

    /// Directory sections with their entries.
    @Default({}) Map<String, _IconDirectory> directories,
    required _IconThemeCache cache,
  }) = ___IconTheme;

  static Future<_IconTheme> load(String theme) async {
    List<Directory> baseDirectories =
        await whereExists(getIconBaseDirectories().map(Directory.new)).toList();
    Map<String, FileSystemEntity> baseDirectoryContents =
        await getDirectoryContents(Stream.fromIterable(baseDirectories));
    Map<String, File> themeFiles = await getThemeFileHierarchy(theme);

    File? getIndexThemeFile() {
      for (Directory baseDir in baseDirectories) {
        File? indexFile =
            themeFiles[path.join(baseDir.path, theme, 'index.theme')];
        if (indexFile != null) {
          return indexFile;
        }
      }
      return null;
    }

    File? indexFile = getIndexThemeFile();
    if (indexFile == null) {
      throw FileSystemException(
          'No `index.theme` could be found for this theme');
    }

    String content = await indexFile.readAsString();
    Map<String, Map<String, Entry>> sections = parseSections(content);

    final entries = sections['Icon Theme'] ?? {};

    Map<String, _IconDirectory> iconDirectories = {};
    List<String>? directories =
        entries[IconThemeKey.directories.string]?.value.getStringList(',');

    if (directories != null) {
      for (String dir in directories) {
        Map<String, Entry>? entries = sections[dir];
        if (entries == null) {
          continue;
        }
        try {
          String? type = entries[IconThemeKey.type.string]?.value;

          iconDirectories.putIfAbsent(
            dir,
            () => _IconDirectory(
              size: entries[IconThemeKey.size.string]!.value.getInteger()!,
              type: _IconType.values.firstWhereOrNull((e) => e.string == type),
              scale: entries[IconThemeKey.scale.string]?.value.getInteger(),
              minSize: entries[IconThemeKey.minSize.string]?.value.getInteger(),
              maxSize: entries[IconThemeKey.maxSize.string]?.value.getInteger(),
              threshold:
                  entries[IconThemeKey.threshold.string]?.value.getInteger(),
            ),
          );
        } catch (_) {
          continue;
        }
      }
    }

    List<String> parents =
        entries[IconThemeKey.inherits.string]?.value.getStringList(',') ?? [];
    if (theme != 'hicolor' && !parents.contains('hicolor')) {
      // hicolor must always be in the inheritance tree.
      parents.add('hicolor');
    }

    return _IconTheme(
      name: theme,
      entries: entries,
      directories: iconDirectories,
      parents: await Future.wait(parents.map((e) => _IconTheme.load(e))),
      cache: _IconThemeCache(
        baseDirectories: baseDirectories,
        baseDirectoryContents: baseDirectoryContents,
        themeFiles: themeFiles,
      ),
    );
  }

  File? _findIcon(String icon, int size, int scale, Set<String> extensions) {
    File? file = _findIconHelper(icon, size, scale, extensions);
    if (file != null) {
      return file;
    }
    return _lookupFallbackIcon(icon, extensions);
  }

  File? _findIconHelper(
      String icon, int size, int scale, Set<String> extensions) {
    File? file = _lookupIcon(icon, size, scale, extensions);
    if (file != null) {
      return file;
    }

    for (_IconTheme parent in parents) {
      File? file = parent._findIconHelper(icon, size, scale, extensions);
      if (file != null) {
        return file;
      }
    }

    return null;
  }

  File? _lookupIcon(
      String iconName, int size, int scale, Set<String> extensions) {
    for (final subDir in directories.entries) {
      for (Directory baseDir in cache.baseDirectories) {
        for (String extension in extensions) {
          if (_directoryMatchesSize(subDir.value, size, scale)) {
            String filename = path.join(
                baseDir.path, name, subDir.key, '$iconName.$extension');
            File? file = cache.themeFiles[filename];
            if (file != null) {
              return file;
            }
          }
        }
      }
    }

    int? minimalSize;
    File? closestFile;

    for (final subDir in directories.entries) {
      for (Directory baseDir in cache.baseDirectories) {
        for (String extension in extensions) {
          String filename =
              path.join(baseDir.path, name, subDir.key, '$iconName.$extension');
          File? file = cache.themeFiles[filename];
          if (file != null) {
            final sizeDistance =
                _directorySizeDistance(subDir.value, size, scale);
            if ((minimalSize == null || sizeDistance < minimalSize)) {
              closestFile = file;
              minimalSize = sizeDistance;
            }
          }
        }
      }
    }

    return closestFile;
  }

  bool _directoryMatchesSize(_IconDirectory dir, int iconSize, int iconScale) {
    if (dir.scale != iconScale) {
      return false;
    }
    switch (dir.type) {
      case _IconType.fixed:
        return dir.size == iconSize;
      case _IconType.scaled:
        return dir.minSize <= iconSize && iconSize <= dir.maxSize;
      case _IconType.threshold:
        return dir.size - dir.threshold <= iconSize &&
            iconSize <= dir.size + dir.threshold;
    }
  }

  File? _lookupFallbackIcon(String iconName, Set<String> extensions) {
    for (Directory baseDir in cache.baseDirectories) {
      for (String extension in extensions) {
        FileSystemEntity? file = cache.baseDirectoryContents[
            path.join(baseDir.path, '$iconName.$extension')];
        if (file is File) {
          return file;
        }
      }
    }
    return null;
  }
}

enum _IconType {
  fixed('Fixed'),
  scaled('Scaled'),
  threshold('Threshold');

  final String string;

  const _IconType(this.string);
}

class _IconDirectory {
  int size;
  _IconType type;
  int scale;
  int minSize;
  int maxSize;
  int threshold;

  _IconDirectory({
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
}

int _directorySizeDistance(_IconDirectory dir, int iconSize, int iconScale) {
  switch (dir.type) {
    case _IconType.fixed:
      return (dir.size * dir.scale - iconSize * iconScale).abs();
    case _IconType.scaled:
      if (iconSize * iconScale < dir.minSize * dir.scale) {
        return dir.minSize * dir.scale - iconSize * iconScale;
      }
      if (iconSize * iconScale > dir.minSize * dir.scale) {
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

extension _CollectionExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

class _IconThemeCache {
  List<Directory> baseDirectories;
  Map<String, FileSystemEntity> baseDirectoryContents;
  Map<String, File> themeFiles;

  _IconThemeCache({
    required this.baseDirectories,
    required this.themeFiles,
    required this.baseDirectoryContents,
  });
}

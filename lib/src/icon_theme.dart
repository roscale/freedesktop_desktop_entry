import 'dart:io';

import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'package:freedesktop_desktop_entry/src/icon_theme_key.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;

import 'entry.dart';

part 'icon_theme.freezed.dart';

@freezed
class IconTheme with _$IconTheme {
  const IconTheme._();

  const factory IconTheme({
    required String name,

    /// Entries from `[Icon Theme]`.
    required Map<String, Entry> entries,
    @Default([]) List<IconTheme> parents,

    /// Directory sections with their entries.
    @Default({}) Map<String, IconDirectory> directories,
    required IconThemeCache cache,
  }) = _IconTheme;

  static Future<IconTheme> load(String theme) async {
    List<Directory> baseDirectories = await filterExists(getBaseDirectories()).toList();
    Map<String, FileSystemEntity> baseDirectoryContents =
        await getDirectoryContents(Stream.fromIterable(baseDirectories));
    Map<String, File> themeFiles = await getThemeFileHierarchy(theme);

    File? getIndexThemeFile() {
      for (Directory baseDir in baseDirectories) {
        File? indexFile = themeFiles[path.join(baseDir.path, theme, 'index.theme')];
        if (indexFile != null) {
          return indexFile;
        }
      }
      return null;
    }

    File? indexFile = getIndexThemeFile();
    if (indexFile == null) {
      throw FileSystemException('No `index.theme` could be found for this theme');
    }

    String content = await indexFile.readAsString();
    Map<String, Map<String, Entry>> sections = parseSections(content);

    final entries = sections['Icon Theme'] ?? {};

    Map<String, IconDirectory> iconDirectories = {};
    List<String>? directories = entries[IconThemeKey.directories.string]?.value.getStringList(',');

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
            () => IconDirectory(
              size: entries[IconThemeKey.size.string]!.value.getInteger()!,
              type: IconType.values.firstWhereOrNull((e) => e.string == type),
              scale: entries[IconThemeKey.scale.string]?.value.getInteger(),
              minSize: entries[IconThemeKey.minSize.string]?.value.getInteger(),
              maxSize: entries[IconThemeKey.maxSize.string]?.value.getInteger(),
              threshold: entries[IconThemeKey.threshold.string]?.value.getInteger(),
            ),
          );
        } catch (_) {
          continue;
        }
      }
    }

    List<String> parents = entries[IconThemeKey.inherits.string]?.value.getStringList(',') ?? [];
    if (theme != 'hicolor' && !parents.contains('hicolor')) {
      // hicolor must always be in the inheritance tree.
      parents.add('hicolor');
    }

    return IconTheme(
      name: theme,
      entries: entries,
      directories: iconDirectories,
      parents: await Future.wait(parents.map((e) => IconTheme.load(e))),
      cache: IconThemeCache(
        baseDirectories: baseDirectories,
        baseDirectoryContents: baseDirectoryContents,
        themeFiles: themeFiles,
      ),
    );
  }
}

Future<Map<String, File>> getThemeFileHierarchy(String theme) async {
  Map<String, File> cache = {};

  await for (Directory themeDir in getThemeDirectories(theme)) {
    List<MapEntry<String, File>> files = await themeDir.list(recursive: true).where((entity) => entity is File).map(
      (entity) {
        File file = entity as File;
        return MapEntry(file.path, file);
      },
    ).toList();

    cache.addEntries(files);
  }

  return cache;
}

Future<Map<String, FileSystemEntity>> getDirectoryContents(Stream<Directory> directories) async {
  Map<String, FileSystemEntity> contents = {};
  await for (Directory dir in directories) {
    await for (FileSystemEntity entity in dir.list()) {
      contents.putIfAbsent(entity.path, () => entity);
    }
  }
  return contents;
}

Iterable<Directory> getBaseDirectories() sync* {
  String? home = Platform.environment['HOME'];
  List<String>? xdgDataDirs = Platform.environment['XDG_DATA_DIRS']?.split(':');

  if (home != null) {
    yield Directory(path.join(home, 'icons'));
  }

  if (xdgDataDirs != null) {
    for (final dataDir in xdgDataDirs) {
      final dir = Directory(path.join(dataDir, 'icons'));
      yield dir;
    }
  }

  final dir = Directory('/usr/share/pixmaps');
  yield dir;
}

Stream<T> filterExists<T extends FileSystemEntity>(Iterable<T> entities) async* {
  for (T entity in entities) {
    if (await entity.exists()) {
      yield entity;
    }
  }
}

Stream<Directory> getThemeDirectories(String theme) async* {
  for (Directory baseDirectory in getBaseDirectories()) {
    final themeDir = Directory(path.join(baseDirectory.path, theme));
    if (await themeDir.exists()) {
      yield themeDir;
    }
  }
}

File? findIcon(String icon, int size, int scale, IconTheme theme) {
  File? file = _findIconHelper(icon, size, scale, theme);
  if (file != null) {
    return file;
  }
  return lookupFallbackIcon(icon, theme);
}

File? _findIconHelper(String icon, int size, int scale, IconTheme theme) {
  File? file = lookupIcon(icon, size, scale, theme);
  if (file != null) {
    return file;
  }

  for (IconTheme parent in theme.parents) {
    File? file = _findIconHelper(icon, size, scale, parent);
    if (file != null) {
      return file;
    }
  }

  return null;
}

File? lookupIcon(String iconName, int size, int scale, IconTheme theme) {
  for (final subDir in theme.directories.entries) {
    for (Directory baseDir in theme.cache.baseDirectories) {
      for (String extension in ['png']) {
        if (directoryMatchesSize(subDir.value, size, scale)) {
          String filename = path.join(baseDir.path, theme.name, subDir.key, '$iconName.$extension');
          File? file = theme.cache.themeFiles[filename];
          if (file != null) {
            return file;
          }
        }
      }
    }
  }

  int? minimalSize;
  File? closestFile;

  for (final subDir in theme.directories.entries) {
    for (Directory baseDir in theme.cache.baseDirectories) {
      for (String extension in ['png']) {
        String filename = path.join(baseDir.path, theme.name, subDir.key, '$iconName.$extension');
        File? file = theme.cache.themeFiles[filename];
        if (file != null) {
          final sizeDistance = directorySizeDistance(subDir.value, size, scale);
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

File? lookupFallbackIcon(String iconName, IconTheme theme) {
  for (Directory baseDir in theme.cache.baseDirectories) {
    for (String extension in ['png']) {
      FileSystemEntity? file = theme.cache.baseDirectoryContents[path.join(baseDir.path, '$iconName.$extension')];
      if (file is File) {
        return file;
      }
    }
  }
  return null;
}

bool directoryMatchesSize(IconDirectory dir, int iconSize, int iconScale) {
  if (dir.scale != iconScale) {
    return false;
  }
  switch (dir.type) {
    case IconType.fixed:
      return dir.size == iconSize;
    case IconType.scaled:
      return dir.minSize <= iconSize && iconSize <= dir.maxSize;
    case IconType.threshold:
      return dir.size - dir.threshold <= iconSize && iconSize <= dir.size + dir.threshold;
  }
}

enum IconType {
  fixed('Fixed'),
  scaled('Scaled'),
  threshold('Threshold');

  final String string;

  const IconType(this.string);
}

class IconDirectory {
  int size;
  IconType type;
  int scale;
  int minSize;
  int maxSize;
  int threshold;

  IconDirectory({
    required this.size,
    IconType? type,
    int? scale,
    int? minSize,
    int? maxSize,
    int? threshold,
  })  : type = type ?? IconType.threshold,
        scale = scale ?? 1,
        minSize = minSize ?? size,
        maxSize = maxSize ?? size,
        threshold = threshold ?? 2;
}

int directorySizeDistance(IconDirectory dir, int iconSize, int iconScale) {
  switch (dir.type) {
    case IconType.fixed:
      return (dir.size * dir.scale - iconSize * iconScale).abs();
    case IconType.scaled:
      if (iconSize * iconScale < dir.minSize * dir.scale) {
        return dir.minSize * dir.scale - iconSize * iconScale;
      }
      if (iconSize * iconScale > dir.minSize * dir.scale) {
        return iconSize * iconScale - dir.maxSize * dir.scale;
      }
      return 0;
    case IconType.threshold:
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

class IconThemeCache {
  List<Directory> baseDirectories;
  Map<String, FileSystemEntity> baseDirectoryContents;
  Map<String, File> themeFiles;

  IconThemeCache({
    required this.baseDirectories,
    required this.themeFiles,
    required this.baseDirectoryContents,
  });
}

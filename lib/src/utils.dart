import 'dart:io';

import 'package:path/path.dart' as path;

/// https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
Iterable<String> getDataDirectories() sync* {
  yield Platform.environment['XDG_DATA_HOME'] ?? expandEnvironmentVariables(r'$HOME/.local/share');
  yield* (Platform.environment['XDG_DATA_DIRS'] ?? '/usr/local/share:/usr/share').split(':');
}

/// Returns all potential directories where desktop entries might reside.
/// Some directories might not exist.
Iterable<String> getApplicationDirectories() => getDataDirectories().map((dir) => path.join(dir, 'applications'));

// Only if the dollar sign does not have a backslash before it.
final unescapedVariables = RegExp(r'(?<!\\)\$([a-zA-Z_]+[a-zA-Z0-9_]*)');

/// Resolves environment variables. Replaces all $VARS with their value.
String expandEnvironmentVariables(String path) {
  return path.replaceAllMapped(unescapedVariables, (Match match) {
    String env = match[1]!;
    return Platform.environment[env] ?? '';
  });
}

/// Filters out filesystem entities that don't exist.
Stream<T> whereExists<T extends FileSystemEntity>(Iterable<T> entities) async* {
  for (T entity in entities) {
    if (await entity.exists()) {
      yield entity;
    }
  }
}

/// Returns all the places where icons *could* reside. These directories might
/// not actually exist.
Iterable<String> getIconBaseDirectories() sync* {
  String? home = Platform.environment['HOME'];

  if (home != null) {
    yield path.join(home, '.icons');
  }
  yield* getDataDirectories().map((dir) => path.join(dir, 'icons'));
  yield '/usr/share/pixmaps';
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

Future<Map<String, File>> getThemeFileHierarchy(String theme) async {
  Map<String, File> themeFiles = {};

  await for (Directory themeDir in getThemeDirectories(theme)) {
    List<MapEntry<String, File>> files = await themeDir.list(recursive: true).where((entity) => entity is File).map(
      (entity) {
        File file = entity as File;
        return MapEntry(file.path, file);
      },
    ).toList();

    themeFiles.addEntries(files);
  }
  return themeFiles;
}

Stream<Directory> getThemeDirectories(String theme) async* {
  for (String baseDirectory in getIconBaseDirectories()) {
    final themeDir = Directory(path.join(baseDirectory, theme));
    if (await themeDir.exists()) {
      yield themeDir;
    }
  }
}

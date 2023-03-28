import 'dart:io';

import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'package:freedesktop_desktop_entry/src/utils.dart';
import 'package:path/path.dart' as path;

/// Returns all potential directories where desktop entries might reside.
/// Some directories might not exist.
Iterable<String> getApplicationDirectories() => getDataDirectories().map((dir) => path.join(dir, 'applications'));

Future<Map<String, DesktopEntry>> parseAllInstalledDesktopFiles() async {
  Map<String, DesktopEntry> desktopEntries = {};

  await for (final Directory dir in whereExists(getApplicationDirectories().map(Directory.new))) {
    await for (FileSystemEntity entity in dir.list()) {
      if (entity is File) {
        DesktopEntry desktopEntry = await DesktopEntry.parseFile(entity.absolute);
        desktopEntries.putIfAbsent(desktopEntry.id!, () => desktopEntry);
      }
    }
  }
  return desktopEntries;
}

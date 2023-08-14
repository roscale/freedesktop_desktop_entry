import 'dart:io';

import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';

void main() async {
  Directory.current = "test/desktop_entry_files/";
  final file = File("desktop-entry-1.desktop");

  DesktopEntry desktopEntry = await DesktopEntry.parseFile(file);

  LocalizedDesktopEntry localizedDesktopEntry = desktopEntry.localize(lang: 'fr', country: 'BE');
  String? frenchName = localizedDesktopEntry.entries[DesktopEntryKey.name.string];
  print(frenchName);

  String? defaultName = desktopEntry.entries[DesktopEntryKey.name.string]?.value;
  print(defaultName);

  List<String>? frenchKeywords = localizedDesktopEntry.entries[DesktopEntryKey.keywords.string]?.getStringList();
  print(frenchKeywords);

  List<String>? englishKeywords =
      desktopEntry.entries[DesktopEntryKey.keywords.string]?.localizedValues[Locale(lang: 'en')]?.getStringList();
  print(englishKeywords);

  print(desktopEntry.id);

  final allFiles = await parseAllInstalledDesktopFiles();
  print(allFiles.length);
}

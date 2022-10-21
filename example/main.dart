import 'dart:io';

import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';

void main() async {
  final file = File("test/desktop_entry_files/desktop-entry-1.desktop");
  String content = await file.readAsString();
  DesktopEntry desktopEntry = DesktopEntry.parse(content);

  LocalizedDesktopEntry localizedDesktopEntry =
      desktopEntry.localize(lang: 'fr', country: 'BE');
  String? frenchName =
      localizedDesktopEntry.entries[DesktopEntryKey.name.string];
  print(frenchName);

  String? defaultName =
      desktopEntry.entries[DesktopEntryKey.name.string]?.value;
  print(defaultName);

  List<String>? frenchKeywords = localizedDesktopEntry
      .entries[DesktopEntryKey.keywords.string]
      ?.getStringList();
  print(frenchKeywords);

  List<String>? englishKeywords = desktopEntry
      .entries[DesktopEntryKey.keywords.string]
      ?.localizedValues[Locale(lang: 'en')]
      ?.getStringList();
  print(englishKeywords);
}

import 'dart:io';

import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'package:test/test.dart';

void main() {
  final file = File("test/desktop_entry_files/desktop-entry-1.desktop");
  final string = file.readAsStringSync();
  final desktopEntry = DesktopEntry.parse(string);
  LocalizedDesktopEntry localizedDesktopEntry = desktopEntry.localize(lang: 'fr', country: 'BE');

  test('localization', () {
    expect(localizedDesktopEntry.entries[DesktopEntryKey.version.string], '1.0');
    expect(localizedDesktopEntry.entries[DesktopEntryKey.name.string], 'Fichier de test 1');
    expect(localizedDesktopEntry.entries[DesktopEntryKey.genericName.string], 'Desktop entry file');
    expect(localizedDesktopEntry.entries[DesktopEntryKey.comment.string], 'Baguette');
    expect(localizedDesktopEntry.entries[DesktopEntryKey.terminal.string]?.getBoolean(), false);
    expect(localizedDesktopEntry.entries[DesktopEntryKey.keywords.string]?.getStringList(), ['Fichier']);
  });
}

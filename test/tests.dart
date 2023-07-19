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

  test('actions', () {
    expect(localizedDesktopEntry.entries[DesktopEntryKey.actions.string]?.getStringList(), ['new-window']);
    expect(localizedDesktopEntry.actions.length, 1);
    expect(desktopEntry.actions['new-window']?[DesktopEntryKey.name.string]?.value, 'Open new window');
    expect(localizedDesktopEntry.actions['new-window']?[DesktopEntryKey.name.string], 'Ouvrir nouvelle fenêtre');
  });

  test('icon name', () async {
    final themes = FreedesktopIconThemes();
    File? file = await themes.findIcon(
      IconQuery(
        name: 'input-touchpad',
        size: 32,
        extensions: ['png'],
      ),
    );
    assert(file != null);
    assert(file!.path == '/usr/share/icons/hicolor/32x32/devices/input-touchpad.png');
  });

  test('absolute icon path', () async {
    final themes = FreedesktopIconThemes();
    File? file = await themes.findIcon(
      IconQuery(
        name: '/usr/share/icons/hicolor/32x32/devices/input-touchpad.png',
        size: 32, // doesn't matter
        extensions: ['png'], // doesn't matter
      ),
    );
    assert(file != null);
    assert(file!.path == '/usr/share/icons/hicolor/32x32/devices/input-touchpad.png');
  });
}

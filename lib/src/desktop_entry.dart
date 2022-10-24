import 'package:freezed_annotation/freezed_annotation.dart';

import 'desktop_entry_key.dart';
import 'entry.dart';
import 'extensions.dart';
import 'locale.dart';
import 'localized_desktop_entry.dart';

part 'desktop_entry.freezed.dart';

@freezed
class DesktopEntry with _$DesktopEntry {
  const DesktopEntry._();

  const factory DesktopEntry({
    required Map<String, Entry> entries,
    @Default({}) Map<String, Map<String, Entry>> actions,
  }) = _DesktopEntry;

  factory DesktopEntry.parse(String source) {
    var lines = source.split('\n');

    lines = lines.map((String line) {
      return line.trim();
    }).where((String line) {
      // Remove empty lines and comments.
      return line.isNotEmpty && !line.startsWith('#');
    }).toList();

    final List<String> entryLines = [];
    final Map<String, List<String>> actionLines = {};

    List<String>? list;
    for (final line in lines) {
      if (line == '[Desktop Entry]') {
        list = entryLines;
        continue;
      }

      final actionRegex = RegExp(r'^\[Desktop Action (?<action>[ -~]+)\]$');
      final match = actionRegex.firstMatch(line);
      if (match != null) {
        final actionName = match.namedGroup('action')!;
        list = actionLines.putIfAbsent(actionName, () => []);
        continue;
      }

      list?.add(line);
    }

    Map<String, Entry> entries = _parseEntries(entryLines);

    // It is not valid to have an action group for an action identifier not mentioned in the Actions key.
    // These actions must be ignored.
    final List<String>? declaredActions =
        entries[DesktopEntryKey.actions.string]?.value.getStringList();
    actionLines.removeWhere(
        (actionName, _) => !(declaredActions?.contains(actionName) ?? false));

    Map<String, Map<String, Entry>> actions =
        actionLines.map((key, value) => MapEntry(key, _parseEntries(value)));

    return DesktopEntry(entries: entries, actions: actions);
  }

  LocalizedDesktopEntry localize({
    required String lang,
    String? country,
    String? modifier,
  }) {
    final localizedEntries = entries.map(
      (key, value) => MapEntry(
        key,
        value.localize(
          lang: lang,
          country: country,
          modifier: modifier,
        ),
      ),
    );

    final localizedActions = actions.map(
      (actionName, entries) => MapEntry(
        actionName,
        entries.map(
          (key, value) => MapEntry(
            key,
            value.localize(
              lang: lang,
              country: country,
              modifier: modifier,
            ),
          ),
        ),
      ),
    );
    return LocalizedDesktopEntry(
        entries: localizedEntries, actions: localizedActions);
  }
}

Map<String, Entry> _parseEntries(List<String> entryLines) {
  Map<String, Entry> entries = {};

  final mapEntries = entryLines.map((line) {
    final tokens = line.split('=');
    final key = tokens[0].trim();
    final value = tokens.skip(1).join('=').trim();
    return MapEntry(key, value);
  });

  for (MapEntry<String, String> rawEntry in mapEntries) {
    final keyRegex =
        RegExp(r'^(?<name>[A-Za-z0-9-]+)(:?\[(?<locale>[A-Za-z0-9-_.@]+)\])?$');
    var match = keyRegex.firstMatch(rawEntry.key);

    String? name = match?.namedGroup('name');
    String? locale = match?.namedGroup('locale');

    if (name == null) {
      continue;
    }

    Entry getEntry(String name) =>
        entries.putIfAbsent(name, () => Entry(value: ''));

    if (locale == null) {
      // Default value.
      entries[name] = getEntry(name).copyWith(value: rawEntry.value);
      continue;
    }

    match = RegExp(
      r'^(?<lang>[A-Za-z0-9-]+)'
      r'(?:_(?<country>[A-Za-z0-9-]+))?'
      r'(?:\.(?<encoding>[A-Za-z0-9-]+))?'
      r'(?:@(?<modifier>[A-Za-z0-9-]+))?$',
    ).firstMatch(locale);

    String? lang = match?.namedGroup('lang');
    String? country = match?.namedGroup('country');
    String? encoding = match?.namedGroup('encoding');
    String? modifier = match?.namedGroup('modifier');

    if (lang == null) {
      continue;
    }

    final entry = getEntry(name);
    entries[name] = entry.copyWith(
      localizedValues: {
        ...entry.localizedValues,
        Locale(
            lang: lang,
            country: country,
            encoding: encoding,
            modifier: modifier): rawEntry.value,
      },
    );
  }

  return entries;
}

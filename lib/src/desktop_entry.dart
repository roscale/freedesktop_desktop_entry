import 'dart:io';

import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart' hide Entry;
import 'package:freezed_annotation/freezed_annotation.dart';

import 'desktop_entry_key.dart';
import 'entry.dart';
import 'extensions.dart';
import 'locale.dart';
import 'localized_desktop_entry.dart';
import 'utils.dart';

part 'desktop_entry.freezed.dart';

Future<Map<String, DesktopEntry>> parseAllInstalledDesktopFiles() async {
  Map<String, DesktopEntry> desktopEntries = {};

  List<Future<DesktopEntry>> futures = [];

  await for (final Directory dir in whereExists(getApplicationDirectories().map(Directory.new))) {
    await for (FileSystemEntity entity in dir.list()) {
      if (entity is File) {
        Future<DesktopEntry> desktopEntry = DesktopEntry.parseFile(entity.absolute);
        futures.add(desktopEntry);
      }
    }
  }

  for (DesktopEntry desktopEntry in await futures.wait) {
    desktopEntries.putIfAbsent(desktopEntry.id!, () => desktopEntry);
  }

  return desktopEntries;
}

@freezed
class DesktopEntry with _$DesktopEntry {
  const DesktopEntry._();

  const factory DesktopEntry({
    /// Entries from `[Desktop Entry]`.
    required Map<String, Entry> entries,

    /// Actions with their entries.
    /// A section named `[Desktop Action xyz]` has key `xyz`.
    @Default({}) Map<String, Map<String, Entry>> actions,

    /// The desktop file ID.
    @Default(null) String? id,
  }) = _DesktopEntry;

  factory DesktopEntry.parse(String source) {
    Map<String, Map<String, Entry>> sections = parseSections(source);

    Map<String, Entry> entries = sections["Desktop Entry"] ?? {};
    List<String>? declaredActions = entries[DesktopEntryKey.actions.string]?.value.getStringList();
    Map<String, Map<String, Entry>> actions = getActions(sections, declaredActions);

    return DesktopEntry(
      entries: entries,
      actions: actions,
    );
  }

  static Future<DesktopEntry> parseFile(File file) async {
    String source = await file.readAsString();
    return DesktopEntry.parse(source).copyWith(
      id: getDesktopFileId(file.path),
    );
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
      desktopEntry: this,
      entries: localizedEntries,
      actions: localizedActions,
    );
  }

  bool isHidden() {
    return entries[DesktopEntryKey.name.string] == null ||
        entries[DesktopEntryKey.type.string]?.value != 'Application' ||
        entries[DesktopEntryKey.noDisplay.string]?.value.getBoolean() == true ||
        entries[DesktopEntryKey.hidden.string]?.value.getBoolean() == true;
  }
}

final _sectionRegex = RegExp(r'^\[(?<section>.*)\]$');
final _actionRegex = RegExp(r'^Desktop Action (?<action>[ -~]+)$');
final _entryKeyRegex = RegExp(r'^(?<name>[A-Za-z0-9-]+)(:?\[(?<locale>[A-Za-z0-9-_.@]+)\])?$');
final _localeRegex = RegExp(
  r'^(?<lang>[A-Za-z0-9-]+)'
  r'(?:_(?<country>[A-Za-z0-9-]+))?'
  r'(?:\.(?<encoding>[A-Za-z0-9-]+))?'
  r'(?:@(?<modifier>[A-Za-z0-9-]+))?$',
);
final _applicationsRegex = RegExp(r'^.*applications/');
final _desktopRegex = RegExp(r'.desktop$');

Map<String, Map<String, Entry>> parseSections(String source) {
  String section = "";

  String bySection(String entryLine) {
    section = _sectionRegex.firstMatch(entryLine)?.namedGroup("section") ?? section;
    return section;
  }

  return source
      .split('\n')
      .map((String line) => line.trim())
      // Remove empty lines and comments.
      .where((String line) => line.isNotEmpty && !line.startsWith('#') && !line.startsWith(';'))
      .groupListsBy(bySection)
      // Skip the first element in `lines` because it's the section header.
      .map((section, lines) => MapEntry(section, parseEntries(lines.skip(1))));
}

typedef EntryLine = ({
  String? name,
  (
    String? lang,
    String? country,
    String? encoding,
    String? modifier,
  ) locale,
  String value,
});

Map<String, Entry> parseEntries(Iterable<String> entryLines) {
  EntryLine readLine(String line) {
    var delimiter = line.indexOf("=");
    String key = line.substring(0, delimiter).trim();
    String value = line.substring(delimiter + 1).trim();

    var match = _entryKeyRegex.firstMatch(key);
    String? name = match?.namedGroup('name');
    String? locale = match?.namedGroup('locale');

    match = locale != null ? _localeRegex.firstMatch(locale) : null;
    String? lang = match?.namedGroup('lang');
    String? country = match?.namedGroup('country');
    String? encoding = match?.namedGroup('encoding');
    String? modifier = match?.namedGroup('modifier');

    return (name: name, locale: (lang, country, encoding, modifier), value: value);
  }

  bool isEntryValid(EntryLine entryLine) {
    final (lang, country, encoding, modifier) = entryLine.locale;
    // If locale exists, lang must be non-null.
    bool hasLocale = lang != null || country != null || encoding != null || modifier != null;
    return entryLine.name != null && (!hasLocale || lang != null);
  }

  // Accumulate into a mutable map because it's faster.
  Map<String, Map<Locale, String>> localizedValuesMap = {};

  Entry combine(Entry? entry, tuple) {
    entry ??= Entry(name: tuple.name, value: '', localizedValues: <Locale, String>{}.lockUnsafe);

    final (lang, country, encoding, modifier) = tuple.locale;
    bool hasLocale = lang != null || country != null || encoding != null || modifier != null;

    if (!hasLocale) {
      // Default value.
      return entry.copyWith(value: tuple.value);
    }

    final localizedValues = localizedValuesMap.putIfAbsent(entry.name, () => {});
    localizedValues[Locale(
      lang: lang!,
      country: country,
      encoding: encoding,
      modifier: modifier,
    )] = tuple.value;

    return entry;
  }

  return entryLines
      .map(readLine)
      .where(isEntryValid)
      .groupFoldBy((entryLine) => entryLine.name!, combine)
      // Transform mutable maps into immutable ones.
      .map((key, value) => MapEntry(
            key,
            value.copyWith(localizedValues: (localizedValuesMap[value.name] ?? const {}).lockUnsafe),
          ));
}

Map<String, Map<String, Entry>> getActions(Map<String, Map<String, Entry>> sections, List<String>? declaredActions) {
  if (declaredActions == null) {
    return {};
  }

  final entries = sections.entries
      .map((entry) {
        RegExpMatch? match = _actionRegex.firstMatch(entry.key);
        String? actionName = match?.namedGroup('action');
        return (actionName, entry.value);
      })
      // It is not valid to have an action group for an action identifier not mentioned in the Actions key.
      // These actions must be ignored.
      .where((tuple) => tuple.$1 != null && declaredActions.contains(tuple.$1))
      .map((tuple) => MapEntry(tuple.$1!, tuple.$2));

  return Map.fromEntries(entries);
}

String getDesktopFileId(String path) {
  return path.replaceFirst(_applicationsRegex, '').replaceFirst(_desktopRegex, '').replaceAll('/', '-');
}

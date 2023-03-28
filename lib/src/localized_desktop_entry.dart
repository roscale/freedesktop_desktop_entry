import 'package:freedesktop_desktop_entry/src/desktop_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_desktop_entry.freezed.dart';

@freezed
class LocalizedDesktopEntry with _$LocalizedDesktopEntry {
  const LocalizedDesktopEntry._();

  const factory LocalizedDesktopEntry({
    required DesktopEntry desktopEntry,
    required Map<String, String> entries,
    @Default({}) Map<String, Map<String, String>> actions,
  }) = _LocalizedDesktopEntry;
}

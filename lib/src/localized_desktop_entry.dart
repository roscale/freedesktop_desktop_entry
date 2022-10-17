import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_desktop_entry.freezed.dart';

@freezed
class LocalizedDesktopEntry with _$LocalizedDesktopEntry {
  const LocalizedDesktopEntry._();

  const factory LocalizedDesktopEntry({
    required Map<String, String> entries,
  }) = _LocalizedDesktopEntry;
}

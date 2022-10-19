import 'package:freezed_annotation/freezed_annotation.dart';

import 'locale.dart';

part 'entry.freezed.dart';

@freezed
class Entry with _$Entry {
  const Entry._();

  const factory Entry({
    required String value,
    @Default({}) Map<Locale, String> localizedValues,
  }) = _Entry;

  String localize({
    required String lang,
    String? country,
    String? modifier,
  }) {
    if (country != null && modifier != null) {
      return localizedValues[Locale(
            lang: lang,
            country: country,
            encoding: null,
            modifier: modifier,
          )] ??
          localizedValues[Locale(
            lang: lang,
            country: country,
            encoding: null,
            modifier: null,
          )] ??
          localizedValues[Locale(
            lang: lang,
            country: null,
            encoding: null,
            modifier: modifier,
          )] ??
          localizedValues[Locale(
            lang: lang,
            country: null,
            encoding: null,
            modifier: null,
          )] ??
          value;
    }

    if (country != null) {
      return localizedValues[Locale(
            lang: lang,
            country: country,
            encoding: null,
            modifier: null,
          )] ??
          localizedValues[Locale(
            lang: lang,
            country: null,
            encoding: null,
            modifier: null,
          )] ??
          value;
    }

    if (modifier != null) {
      return localizedValues[Locale(
            lang: lang,
            country: null,
            encoding: null,
            modifier: modifier,
          )] ??
          localizedValues[Locale(
            lang: lang,
            country: null,
            encoding: null,
            modifier: null,
          )] ??
          value;
    }

    return localizedValues[Locale(
          lang: lang,
          country: null,
          encoding: null,
          modifier: null,
        )] ??
        value;
  }
}

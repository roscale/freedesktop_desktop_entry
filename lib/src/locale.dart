import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale.freezed.dart';

@freezed
class Locale with _$Locale {
  const factory Locale({
    required String lang,
    String? country,
    String? encoding,
    String? modifier,
  }) = _Locale;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Locale {
  String get lang => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get encoding => throw _privateConstructorUsedError;
  String? get modifier => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocaleCopyWith<Locale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocaleCopyWith<$Res> {
  factory $LocaleCopyWith(Locale value, $Res Function(Locale) then) =
      _$LocaleCopyWithImpl<$Res, Locale>;
  @useResult
  $Res call({String lang, String? country, String? encoding, String? modifier});
}

/// @nodoc
class _$LocaleCopyWithImpl<$Res, $Val extends Locale>
    implements $LocaleCopyWith<$Res> {
  _$LocaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lang = null,
    Object? country = freezed,
    Object? encoding = freezed,
    Object? modifier = freezed,
  }) {
    return _then(_value.copyWith(
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      encoding: freezed == encoding
          ? _value.encoding
          : encoding // ignore: cast_nullable_to_non_nullable
              as String?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocaleCopyWith<$Res> implements $LocaleCopyWith<$Res> {
  factory _$$_LocaleCopyWith(_$_Locale value, $Res Function(_$_Locale) then) =
      __$$_LocaleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String lang, String? country, String? encoding, String? modifier});
}

/// @nodoc
class __$$_LocaleCopyWithImpl<$Res>
    extends _$LocaleCopyWithImpl<$Res, _$_Locale>
    implements _$$_LocaleCopyWith<$Res> {
  __$$_LocaleCopyWithImpl(_$_Locale _value, $Res Function(_$_Locale) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lang = null,
    Object? country = freezed,
    Object? encoding = freezed,
    Object? modifier = freezed,
  }) {
    return _then(_$_Locale(
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      encoding: freezed == encoding
          ? _value.encoding
          : encoding // ignore: cast_nullable_to_non_nullable
              as String?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Locale implements _Locale {
  const _$_Locale(
      {required this.lang, this.country, this.encoding, this.modifier});

  @override
  final String lang;
  @override
  final String? country;
  @override
  final String? encoding;
  @override
  final String? modifier;

  @override
  String toString() {
    return 'Locale(lang: $lang, country: $country, encoding: $encoding, modifier: $modifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Locale &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.encoding, encoding) ||
                other.encoding == encoding) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lang, country, encoding, modifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocaleCopyWith<_$_Locale> get copyWith =>
      __$$_LocaleCopyWithImpl<_$_Locale>(this, _$identity);
}

abstract class _Locale implements Locale {
  const factory _Locale(
      {required final String lang,
      final String? country,
      final String? encoding,
      final String? modifier}) = _$_Locale;

  @override
  String get lang;
  @override
  String? get country;
  @override
  String? get encoding;
  @override
  String? get modifier;
  @override
  @JsonKey(ignore: true)
  _$$_LocaleCopyWith<_$_Locale> get copyWith =>
      throw _privateConstructorUsedError;
}

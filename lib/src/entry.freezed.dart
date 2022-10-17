// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Entry {
  String get value => throw _privateConstructorUsedError;
  Map<Locale, String> get localizedValues => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res, Entry>;
  @useResult
  $Res call({String value, Map<Locale, String> localizedValues});
}

/// @nodoc
class _$EntryCopyWithImpl<$Res, $Val extends Entry>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? localizedValues = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      localizedValues: null == localizedValues
          ? _value.localizedValues
          : localizedValues // ignore: cast_nullable_to_non_nullable
              as Map<Locale, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EntryCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$$_EntryCopyWith(_$_Entry value, $Res Function(_$_Entry) then) =
      __$$_EntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value, Map<Locale, String> localizedValues});
}

/// @nodoc
class __$$_EntryCopyWithImpl<$Res> extends _$EntryCopyWithImpl<$Res, _$_Entry>
    implements _$$_EntryCopyWith<$Res> {
  __$$_EntryCopyWithImpl(_$_Entry _value, $Res Function(_$_Entry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? localizedValues = null,
  }) {
    return _then(_$_Entry(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      localizedValues: null == localizedValues
          ? _value._localizedValues
          : localizedValues // ignore: cast_nullable_to_non_nullable
              as Map<Locale, String>,
    ));
  }
}

/// @nodoc

class _$_Entry extends _Entry {
  const _$_Entry(
      {required this.value, required final Map<Locale, String> localizedValues})
      : _localizedValues = localizedValues,
        super._();

  @override
  final String value;
  final Map<Locale, String> _localizedValues;
  @override
  Map<Locale, String> get localizedValues {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_localizedValues);
  }

  @override
  String toString() {
    return 'Entry(value: $value, localizedValues: $localizedValues)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Entry &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other._localizedValues, _localizedValues));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value,
      const DeepCollectionEquality().hash(_localizedValues));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EntryCopyWith<_$_Entry> get copyWith =>
      __$$_EntryCopyWithImpl<_$_Entry>(this, _$identity);
}

abstract class _Entry extends Entry {
  const factory _Entry(
      {required final String value,
      required final Map<Locale, String> localizedValues}) = _$_Entry;
  const _Entry._() : super._();

  @override
  String get value;
  @override
  Map<Locale, String> get localizedValues;
  @override
  @JsonKey(ignore: true)
  _$$_EntryCopyWith<_$_Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

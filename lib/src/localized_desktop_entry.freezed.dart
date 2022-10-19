// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'localized_desktop_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalizedDesktopEntry {
  Map<String, String> get entries => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get actions =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalizedDesktopEntryCopyWith<LocalizedDesktopEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizedDesktopEntryCopyWith<$Res> {
  factory $LocalizedDesktopEntryCopyWith(LocalizedDesktopEntry value,
          $Res Function(LocalizedDesktopEntry) then) =
      _$LocalizedDesktopEntryCopyWithImpl<$Res, LocalizedDesktopEntry>;
  @useResult
  $Res call(
      {Map<String, String> entries, Map<String, Map<String, String>> actions});
}

/// @nodoc
class _$LocalizedDesktopEntryCopyWithImpl<$Res,
        $Val extends LocalizedDesktopEntry>
    implements $LocalizedDesktopEntryCopyWith<$Res> {
  _$LocalizedDesktopEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? actions = null,
  }) {
    return _then(_value.copyWith(
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalizedDesktopEntryCopyWith<$Res>
    implements $LocalizedDesktopEntryCopyWith<$Res> {
  factory _$$_LocalizedDesktopEntryCopyWith(_$_LocalizedDesktopEntry value,
          $Res Function(_$_LocalizedDesktopEntry) then) =
      __$$_LocalizedDesktopEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> entries, Map<String, Map<String, String>> actions});
}

/// @nodoc
class __$$_LocalizedDesktopEntryCopyWithImpl<$Res>
    extends _$LocalizedDesktopEntryCopyWithImpl<$Res, _$_LocalizedDesktopEntry>
    implements _$$_LocalizedDesktopEntryCopyWith<$Res> {
  __$$_LocalizedDesktopEntryCopyWithImpl(_$_LocalizedDesktopEntry _value,
      $Res Function(_$_LocalizedDesktopEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? actions = null,
  }) {
    return _then(_$_LocalizedDesktopEntry(
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
    ));
  }
}

/// @nodoc

class _$_LocalizedDesktopEntry extends _LocalizedDesktopEntry {
  const _$_LocalizedDesktopEntry(
      {required final Map<String, String> entries,
      final Map<String, Map<String, String>> actions = const {}})
      : _entries = entries,
        _actions = actions,
        super._();

  final Map<String, String> _entries;
  @override
  Map<String, String> get entries {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_entries);
  }

  final Map<String, Map<String, String>> _actions;
  @override
  @JsonKey()
  Map<String, Map<String, String>> get actions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actions);
  }

  @override
  String toString() {
    return 'LocalizedDesktopEntry(entries: $entries, actions: $actions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalizedDesktopEntry &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entries),
      const DeepCollectionEquality().hash(_actions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalizedDesktopEntryCopyWith<_$_LocalizedDesktopEntry> get copyWith =>
      __$$_LocalizedDesktopEntryCopyWithImpl<_$_LocalizedDesktopEntry>(
          this, _$identity);
}

abstract class _LocalizedDesktopEntry extends LocalizedDesktopEntry {
  const factory _LocalizedDesktopEntry(
          {required final Map<String, String> entries,
          final Map<String, Map<String, String>> actions}) =
      _$_LocalizedDesktopEntry;
  const _LocalizedDesktopEntry._() : super._();

  @override
  Map<String, String> get entries;
  @override
  Map<String, Map<String, String>> get actions;
  @override
  @JsonKey(ignore: true)
  _$$_LocalizedDesktopEntryCopyWith<_$_LocalizedDesktopEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

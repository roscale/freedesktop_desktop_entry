// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DesktopEntry {
  /// Entries from `[Desktop Entry]`.
  Map<String, Entry> get entries => throw _privateConstructorUsedError;

  /// Actions with their entries.
  /// A section named `[Desktop Action xyz]` has key `xyz`.
  Map<String, Map<String, Entry>> get actions =>
      throw _privateConstructorUsedError;

  /// The desktop file ID.
  String? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DesktopEntryCopyWith<DesktopEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesktopEntryCopyWith<$Res> {
  factory $DesktopEntryCopyWith(
          DesktopEntry value, $Res Function(DesktopEntry) then) =
      _$DesktopEntryCopyWithImpl<$Res, DesktopEntry>;
  @useResult
  $Res call(
      {Map<String, Entry> entries,
      Map<String, Map<String, Entry>> actions,
      String? id});
}

/// @nodoc
class _$DesktopEntryCopyWithImpl<$Res, $Val extends DesktopEntry>
    implements $DesktopEntryCopyWith<$Res> {
  _$DesktopEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? actions = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, Entry>,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, Entry>>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DesktopEntryCopyWith<$Res>
    implements $DesktopEntryCopyWith<$Res> {
  factory _$$_DesktopEntryCopyWith(
          _$_DesktopEntry value, $Res Function(_$_DesktopEntry) then) =
      __$$_DesktopEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Entry> entries,
      Map<String, Map<String, Entry>> actions,
      String? id});
}

/// @nodoc
class __$$_DesktopEntryCopyWithImpl<$Res>
    extends _$DesktopEntryCopyWithImpl<$Res, _$_DesktopEntry>
    implements _$$_DesktopEntryCopyWith<$Res> {
  __$$_DesktopEntryCopyWithImpl(
      _$_DesktopEntry _value, $Res Function(_$_DesktopEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? actions = null,
    Object? id = freezed,
  }) {
    return _then(_$_DesktopEntry(
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, Entry>,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, Entry>>,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DesktopEntry extends _DesktopEntry {
  const _$_DesktopEntry(
      {required final Map<String, Entry> entries,
      final Map<String, Map<String, Entry>> actions = const {},
      this.id = null})
      : _entries = entries,
        _actions = actions,
        super._();

  /// Entries from `[Desktop Entry]`.
  final Map<String, Entry> _entries;

  /// Entries from `[Desktop Entry]`.
  @override
  Map<String, Entry> get entries {
    if (_entries is EqualUnmodifiableMapView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_entries);
  }

  /// Actions with their entries.
  /// A section named `[Desktop Action xyz]` has key `xyz`.
  final Map<String, Map<String, Entry>> _actions;

  /// Actions with their entries.
  /// A section named `[Desktop Action xyz]` has key `xyz`.
  @override
  @JsonKey()
  Map<String, Map<String, Entry>> get actions {
    if (_actions is EqualUnmodifiableMapView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actions);
  }

  /// The desktop file ID.
  @override
  @JsonKey()
  final String? id;

  @override
  String toString() {
    return 'DesktopEntry(entries: $entries, actions: $actions, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DesktopEntry &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entries),
      const DeepCollectionEquality().hash(_actions),
      id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DesktopEntryCopyWith<_$_DesktopEntry> get copyWith =>
      __$$_DesktopEntryCopyWithImpl<_$_DesktopEntry>(this, _$identity);
}

abstract class _DesktopEntry extends DesktopEntry {
  const factory _DesktopEntry(
      {required final Map<String, Entry> entries,
      final Map<String, Map<String, Entry>> actions,
      final String? id}) = _$_DesktopEntry;
  const _DesktopEntry._() : super._();

  @override

  /// Entries from `[Desktop Entry]`.
  Map<String, Entry> get entries;
  @override

  /// Actions with their entries.
  /// A section named `[Desktop Action xyz]` has key `xyz`.
  Map<String, Map<String, Entry>> get actions;
  @override

  /// The desktop file ID.
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_DesktopEntryCopyWith<_$_DesktopEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

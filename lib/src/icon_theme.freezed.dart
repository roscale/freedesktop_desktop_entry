// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'icon_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$_IconTheme {
  String get name => throw _privateConstructorUsedError;

  /// Entries from `[Icon Theme]`.
  Map<String, Entry> get entries => throw _privateConstructorUsedError;
  List<_IconTheme> get parents => throw _privateConstructorUsedError;

  /// Directory sections with their entries.
  Map<String, _IconDirectory> get directories =>
      throw _privateConstructorUsedError;
  _IconThemeCache get cache => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$IconThemeCopyWith<_IconTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$IconThemeCopyWith<$Res> {
  factory _$IconThemeCopyWith(
          _IconTheme value, $Res Function(_IconTheme) then) =
      __$IconThemeCopyWithImpl<$Res, _IconTheme>;
  @useResult
  $Res call(
      {String name,
      Map<String, Entry> entries,
      List<_IconTheme> parents,
      Map<String, _IconDirectory> directories,
      _IconThemeCache cache});
}

/// @nodoc
class __$IconThemeCopyWithImpl<$Res, $Val extends _IconTheme>
    implements _$IconThemeCopyWith<$Res> {
  __$IconThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? entries = null,
    Object? parents = null,
    Object? directories = null,
    Object? cache = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, Entry>,
      parents: null == parents
          ? _value.parents
          : parents // ignore: cast_nullable_to_non_nullable
              as List<_IconTheme>,
      directories: null == directories
          ? _value.directories
          : directories // ignore: cast_nullable_to_non_nullable
              as Map<String, _IconDirectory>,
      cache: null == cache
          ? _value.cache
          : cache // ignore: cast_nullable_to_non_nullable
              as _IconThemeCache,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$___IconThemeCopyWith<$Res>
    implements _$IconThemeCopyWith<$Res> {
  factory _$$___IconThemeCopyWith(
          _$___IconTheme value, $Res Function(_$___IconTheme) then) =
      __$$___IconThemeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Map<String, Entry> entries,
      List<_IconTheme> parents,
      Map<String, _IconDirectory> directories,
      _IconThemeCache cache});
}

/// @nodoc
class __$$___IconThemeCopyWithImpl<$Res>
    extends __$IconThemeCopyWithImpl<$Res, _$___IconTheme>
    implements _$$___IconThemeCopyWith<$Res> {
  __$$___IconThemeCopyWithImpl(
      _$___IconTheme _value, $Res Function(_$___IconTheme) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? entries = null,
    Object? parents = null,
    Object? directories = null,
    Object? cache = null,
  }) {
    return _then(_$___IconTheme(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as Map<String, Entry>,
      parents: null == parents
          ? _value._parents
          : parents // ignore: cast_nullable_to_non_nullable
              as List<_IconTheme>,
      directories: null == directories
          ? _value._directories
          : directories // ignore: cast_nullable_to_non_nullable
              as Map<String, _IconDirectory>,
      cache: null == cache
          ? _value.cache
          : cache // ignore: cast_nullable_to_non_nullable
              as _IconThemeCache,
    ));
  }
}

/// @nodoc

class _$___IconTheme extends ___IconTheme {
  const _$___IconTheme(
      {required this.name,
      required final Map<String, Entry> entries,
      final List<_IconTheme> parents = const [],
      final Map<String, _IconDirectory> directories = const {},
      required this.cache})
      : _entries = entries,
        _parents = parents,
        _directories = directories,
        super._();

  @override
  final String name;

  /// Entries from `[Icon Theme]`.
  final Map<String, Entry> _entries;

  /// Entries from `[Icon Theme]`.
  @override
  Map<String, Entry> get entries {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_entries);
  }

  final List<_IconTheme> _parents;
  @override
  @JsonKey()
  List<_IconTheme> get parents {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parents);
  }

  /// Directory sections with their entries.
  final Map<String, _IconDirectory> _directories;

  /// Directory sections with their entries.
  @override
  @JsonKey()
  Map<String, _IconDirectory> get directories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_directories);
  }

  @override
  final _IconThemeCache cache;

  @override
  String toString() {
    return '_IconTheme(name: $name, entries: $entries, parents: $parents, directories: $directories, cache: $cache)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$___IconTheme &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            const DeepCollectionEquality().equals(other._parents, _parents) &&
            const DeepCollectionEquality()
                .equals(other._directories, _directories) &&
            (identical(other.cache, cache) || other.cache == cache));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_entries),
      const DeepCollectionEquality().hash(_parents),
      const DeepCollectionEquality().hash(_directories),
      cache);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$___IconThemeCopyWith<_$___IconTheme> get copyWith =>
      __$$___IconThemeCopyWithImpl<_$___IconTheme>(this, _$identity);
}

abstract class ___IconTheme extends _IconTheme {
  const factory ___IconTheme(
      {required final String name,
      required final Map<String, Entry> entries,
      final List<_IconTheme> parents,
      final Map<String, _IconDirectory> directories,
      required final _IconThemeCache cache}) = _$___IconTheme;
  const ___IconTheme._() : super._();

  @override
  String get name;
  @override

  /// Entries from `[Icon Theme]`.
  Map<String, Entry> get entries;
  @override
  List<_IconTheme> get parents;
  @override

  /// Directory sections with their entries.
  Map<String, _IconDirectory> get directories;
  @override
  _IconThemeCache get cache;
  @override
  @JsonKey(ignore: true)
  _$$___IconThemeCopyWith<_$___IconTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

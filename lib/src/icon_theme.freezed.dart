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
mixin _$IconTheme {
  String get name => throw _privateConstructorUsedError;

  /// Entries from `[Icon Theme]`.
  Map<String, Entry> get entries => throw _privateConstructorUsedError;
  List<IconTheme> get parents => throw _privateConstructorUsedError;

  /// Directory sections with their entries.
  Map<String, IconDirectory> get directories =>
      throw _privateConstructorUsedError;
  IconThemeCache get cache => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IconThemeCopyWith<IconTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IconThemeCopyWith<$Res> {
  factory $IconThemeCopyWith(IconTheme value, $Res Function(IconTheme) then) =
      _$IconThemeCopyWithImpl<$Res, IconTheme>;
  @useResult
  $Res call(
      {String name,
      Map<String, Entry> entries,
      List<IconTheme> parents,
      Map<String, IconDirectory> directories,
      IconThemeCache cache});
}

/// @nodoc
class _$IconThemeCopyWithImpl<$Res, $Val extends IconTheme>
    implements $IconThemeCopyWith<$Res> {
  _$IconThemeCopyWithImpl(this._value, this._then);

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
              as List<IconTheme>,
      directories: null == directories
          ? _value.directories
          : directories // ignore: cast_nullable_to_non_nullable
              as Map<String, IconDirectory>,
      cache: null == cache
          ? _value.cache
          : cache // ignore: cast_nullable_to_non_nullable
              as IconThemeCache,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IconThemeCopyWith<$Res> implements $IconThemeCopyWith<$Res> {
  factory _$$_IconThemeCopyWith(
          _$_IconTheme value, $Res Function(_$_IconTheme) then) =
      __$$_IconThemeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Map<String, Entry> entries,
      List<IconTheme> parents,
      Map<String, IconDirectory> directories,
      IconThemeCache cache});
}

/// @nodoc
class __$$_IconThemeCopyWithImpl<$Res>
    extends _$IconThemeCopyWithImpl<$Res, _$_IconTheme>
    implements _$$_IconThemeCopyWith<$Res> {
  __$$_IconThemeCopyWithImpl(
      _$_IconTheme _value, $Res Function(_$_IconTheme) _then)
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
    return _then(_$_IconTheme(
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
              as List<IconTheme>,
      directories: null == directories
          ? _value._directories
          : directories // ignore: cast_nullable_to_non_nullable
              as Map<String, IconDirectory>,
      cache: null == cache
          ? _value.cache
          : cache // ignore: cast_nullable_to_non_nullable
              as IconThemeCache,
    ));
  }
}

/// @nodoc

class _$_IconTheme extends _IconTheme {
  const _$_IconTheme(
      {required this.name,
      required final Map<String, Entry> entries,
      final List<IconTheme> parents = const [],
      final Map<String, IconDirectory> directories = const {},
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

  final List<IconTheme> _parents;
  @override
  @JsonKey()
  List<IconTheme> get parents {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parents);
  }

  /// Directory sections with their entries.
  final Map<String, IconDirectory> _directories;

  /// Directory sections with their entries.
  @override
  @JsonKey()
  Map<String, IconDirectory> get directories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_directories);
  }

  @override
  final IconThemeCache cache;

  @override
  String toString() {
    return 'IconTheme(name: $name, entries: $entries, parents: $parents, directories: $directories, cache: $cache)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IconTheme &&
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
  _$$_IconThemeCopyWith<_$_IconTheme> get copyWith =>
      __$$_IconThemeCopyWithImpl<_$_IconTheme>(this, _$identity);
}

abstract class _IconTheme extends IconTheme {
  const factory _IconTheme(
      {required final String name,
      required final Map<String, Entry> entries,
      final List<IconTheme> parents,
      final Map<String, IconDirectory> directories,
      required final IconThemeCache cache}) = _$_IconTheme;
  const _IconTheme._() : super._();

  @override
  String get name;
  @override

  /// Entries from `[Icon Theme]`.
  Map<String, Entry> get entries;
  @override
  List<IconTheme> get parents;
  @override

  /// Directory sections with their entries.
  Map<String, IconDirectory> get directories;
  @override
  IconThemeCache get cache;
  @override
  @JsonKey(ignore: true)
  _$$_IconThemeCopyWith<_$_IconTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Section _$SectionFromJson(Map<String, dynamic> json) {
  return _Section.fromJson(json);
}

/// @nodoc
mixin _$Section {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get bookPath => throw _privateConstructorUsedError;
  String get bookName => throw _privateConstructorUsedError;
  int get sectionIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionCopyWith<Section> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionCopyWith<$Res> {
  factory $SectionCopyWith(Section value, $Res Function(Section) then) =
      _$SectionCopyWithImpl<$Res, Section>;
  @useResult
  $Res call(
      {int? id,
      String title,
      String bookPath,
      String bookName,
      int sectionIndex});
}

/// @nodoc
class _$SectionCopyWithImpl<$Res, $Val extends Section>
    implements $SectionCopyWith<$Res> {
  _$SectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? bookPath = null,
    Object? bookName = null,
    Object? sectionIndex = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bookPath: null == bookPath
          ? _value.bookPath
          : bookPath // ignore: cast_nullable_to_non_nullable
              as String,
      bookName: null == bookName
          ? _value.bookName
          : bookName // ignore: cast_nullable_to_non_nullable
              as String,
      sectionIndex: null == sectionIndex
          ? _value.sectionIndex
          : sectionIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionImplCopyWith<$Res> implements $SectionCopyWith<$Res> {
  factory _$$SectionImplCopyWith(
          _$SectionImpl value, $Res Function(_$SectionImpl) then) =
      __$$SectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      String bookPath,
      String bookName,
      int sectionIndex});
}

/// @nodoc
class __$$SectionImplCopyWithImpl<$Res>
    extends _$SectionCopyWithImpl<$Res, _$SectionImpl>
    implements _$$SectionImplCopyWith<$Res> {
  __$$SectionImplCopyWithImpl(
      _$SectionImpl _value, $Res Function(_$SectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? bookPath = null,
    Object? bookName = null,
    Object? sectionIndex = null,
  }) {
    return _then(_$SectionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bookPath: null == bookPath
          ? _value.bookPath
          : bookPath // ignore: cast_nullable_to_non_nullable
              as String,
      bookName: null == bookName
          ? _value.bookName
          : bookName // ignore: cast_nullable_to_non_nullable
              as String,
      sectionIndex: null == sectionIndex
          ? _value.sectionIndex
          : sectionIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionImpl implements _Section {
  const _$SectionImpl(
      {this.id,
      required this.title,
      required this.bookPath,
      required this.bookName,
      required this.sectionIndex});

  factory _$SectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String bookPath;
  @override
  final String bookName;
  @override
  final int sectionIndex;

  @override
  String toString() {
    return 'Section(id: $id, title: $title, bookPath: $bookPath, bookName: $bookName, sectionIndex: $sectionIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bookPath, bookPath) ||
                other.bookPath == bookPath) &&
            (identical(other.bookName, bookName) ||
                other.bookName == bookName) &&
            (identical(other.sectionIndex, sectionIndex) ||
                other.sectionIndex == sectionIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, bookPath, bookName, sectionIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      __$$SectionImplCopyWithImpl<_$SectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionImplToJson(
      this,
    );
  }
}

abstract class _Section implements Section {
  const factory _Section(
      {final int? id,
      required final String title,
      required final String bookPath,
      required final String bookName,
      required final int sectionIndex}) = _$SectionImpl;

  factory _Section.fromJson(Map<String, dynamic> json) = _$SectionImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String get bookPath;
  @override
  String get bookName;
  @override
  int get sectionIndex;
  @override
  @JsonKey(ignore: true)
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

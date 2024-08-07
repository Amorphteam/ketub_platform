// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_reference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirestoreReferenceModel _$FirestoreReferenceModelFromJson(
    Map<String, dynamic> json) {
  return _FirestoreReferenceModel.fromJson(json);
}

/// @nodoc
mixin _$FirestoreReferenceModel {
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get bookName => throw _privateConstructorUsedError;
  String get bookPath => throw _privateConstructorUsedError;
  String get navIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreReferenceModelCopyWith<FirestoreReferenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreReferenceModelCopyWith<$Res> {
  factory $FirestoreReferenceModelCopyWith(FirestoreReferenceModel value,
          $Res Function(FirestoreReferenceModel) then) =
      _$FirestoreReferenceModelCopyWithImpl<$Res, FirestoreReferenceModel>;
  @useResult
  $Res call(
      {String userId,
      String title,
      String bookName,
      String bookPath,
      String navIndex});
}

/// @nodoc
class _$FirestoreReferenceModelCopyWithImpl<$Res,
        $Val extends FirestoreReferenceModel>
    implements $FirestoreReferenceModelCopyWith<$Res> {
  _$FirestoreReferenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? title = null,
    Object? bookName = null,
    Object? bookPath = null,
    Object? navIndex = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bookName: null == bookName
          ? _value.bookName
          : bookName // ignore: cast_nullable_to_non_nullable
              as String,
      bookPath: null == bookPath
          ? _value.bookPath
          : bookPath // ignore: cast_nullable_to_non_nullable
              as String,
      navIndex: null == navIndex
          ? _value.navIndex
          : navIndex // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirestoreReferenceModelImplCopyWith<$Res>
    implements $FirestoreReferenceModelCopyWith<$Res> {
  factory _$$FirestoreReferenceModelImplCopyWith(
          _$FirestoreReferenceModelImpl value,
          $Res Function(_$FirestoreReferenceModelImpl) then) =
      __$$FirestoreReferenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String title,
      String bookName,
      String bookPath,
      String navIndex});
}

/// @nodoc
class __$$FirestoreReferenceModelImplCopyWithImpl<$Res>
    extends _$FirestoreReferenceModelCopyWithImpl<$Res,
        _$FirestoreReferenceModelImpl>
    implements _$$FirestoreReferenceModelImplCopyWith<$Res> {
  __$$FirestoreReferenceModelImplCopyWithImpl(
      _$FirestoreReferenceModelImpl _value,
      $Res Function(_$FirestoreReferenceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? title = null,
    Object? bookName = null,
    Object? bookPath = null,
    Object? navIndex = null,
  }) {
    return _then(_$FirestoreReferenceModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bookName: null == bookName
          ? _value.bookName
          : bookName // ignore: cast_nullable_to_non_nullable
              as String,
      bookPath: null == bookPath
          ? _value.bookPath
          : bookPath // ignore: cast_nullable_to_non_nullable
              as String,
      navIndex: null == navIndex
          ? _value.navIndex
          : navIndex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirestoreReferenceModelImpl implements _FirestoreReferenceModel {
  const _$FirestoreReferenceModelImpl(
      {required this.userId,
      required this.title,
      required this.bookName,
      required this.bookPath,
      required this.navIndex});

  factory _$FirestoreReferenceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirestoreReferenceModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String title;
  @override
  final String bookName;
  @override
  final String bookPath;
  @override
  final String navIndex;

  @override
  String toString() {
    return 'FirestoreReferenceModel(userId: $userId, title: $title, bookName: $bookName, bookPath: $bookPath, navIndex: $navIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirestoreReferenceModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bookName, bookName) ||
                other.bookName == bookName) &&
            (identical(other.bookPath, bookPath) ||
                other.bookPath == bookPath) &&
            (identical(other.navIndex, navIndex) ||
                other.navIndex == navIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, title, bookName, bookPath, navIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirestoreReferenceModelImplCopyWith<_$FirestoreReferenceModelImpl>
      get copyWith => __$$FirestoreReferenceModelImplCopyWithImpl<
          _$FirestoreReferenceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirestoreReferenceModelImplToJson(
      this,
    );
  }
}

abstract class _FirestoreReferenceModel implements FirestoreReferenceModel {
  const factory _FirestoreReferenceModel(
      {required final String userId,
      required final String title,
      required final String bookName,
      required final String bookPath,
      required final String navIndex}) = _$FirestoreReferenceModelImpl;

  factory _FirestoreReferenceModel.fromJson(Map<String, dynamic> json) =
      _$FirestoreReferenceModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get title;
  @override
  String get bookName;
  @override
  String get bookPath;
  @override
  String get navIndex;
  @override
  @JsonKey(ignore: true)
  _$$FirestoreReferenceModelImplCopyWith<_$FirestoreReferenceModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

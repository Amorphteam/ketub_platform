// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ListTypeModel _$ListTypeModelFromJson(Map<String, dynamic> json) {
  return _ListTypeModel.fromJson(json);
}

/// @nodoc
mixin _$ListTypeModel {
  ListType get listType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get hasSubLists => throw _privateConstructorUsedError;
  String get featureImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListTypeModelCopyWith<ListTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListTypeModelCopyWith<$Res> {
  factory $ListTypeModelCopyWith(
          ListTypeModel value, $Res Function(ListTypeModel) then) =
      _$ListTypeModelCopyWithImpl<$Res, ListTypeModel>;
  @useResult
  $Res call(
      {ListType listType,
      String title,
      bool hasSubLists,
      String featureImageUrl});
}

/// @nodoc
class _$ListTypeModelCopyWithImpl<$Res, $Val extends ListTypeModel>
    implements $ListTypeModelCopyWith<$Res> {
  _$ListTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listType = null,
    Object? title = null,
    Object? hasSubLists = null,
    Object? featureImageUrl = null,
  }) {
    return _then(_value.copyWith(
      listType: null == listType
          ? _value.listType
          : listType // ignore: cast_nullable_to_non_nullable
              as ListType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hasSubLists: null == hasSubLists
          ? _value.hasSubLists
          : hasSubLists // ignore: cast_nullable_to_non_nullable
              as bool,
      featureImageUrl: null == featureImageUrl
          ? _value.featureImageUrl
          : featureImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListTypeModelImplCopyWith<$Res>
    implements $ListTypeModelCopyWith<$Res> {
  factory _$$ListTypeModelImplCopyWith(
          _$ListTypeModelImpl value, $Res Function(_$ListTypeModelImpl) then) =
      __$$ListTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ListType listType,
      String title,
      bool hasSubLists,
      String featureImageUrl});
}

/// @nodoc
class __$$ListTypeModelImplCopyWithImpl<$Res>
    extends _$ListTypeModelCopyWithImpl<$Res, _$ListTypeModelImpl>
    implements _$$ListTypeModelImplCopyWith<$Res> {
  __$$ListTypeModelImplCopyWithImpl(
      _$ListTypeModelImpl _value, $Res Function(_$ListTypeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listType = null,
    Object? title = null,
    Object? hasSubLists = null,
    Object? featureImageUrl = null,
  }) {
    return _then(_$ListTypeModelImpl(
      listType: null == listType
          ? _value.listType
          : listType // ignore: cast_nullable_to_non_nullable
              as ListType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hasSubLists: null == hasSubLists
          ? _value.hasSubLists
          : hasSubLists // ignore: cast_nullable_to_non_nullable
              as bool,
      featureImageUrl: null == featureImageUrl
          ? _value.featureImageUrl
          : featureImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListTypeModelImpl
    with DiagnosticableTreeMixin
    implements _ListTypeModel {
  const _$ListTypeModelImpl(
      {required this.listType,
      required this.title,
      this.hasSubLists = false,
      required this.featureImageUrl});

  factory _$ListTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListTypeModelImplFromJson(json);

  @override
  final ListType listType;
  @override
  final String title;
  @override
  @JsonKey()
  final bool hasSubLists;
  @override
  final String featureImageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListTypeModel(listType: $listType, title: $title, hasSubLists: $hasSubLists, featureImageUrl: $featureImageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ListTypeModel'))
      ..add(DiagnosticsProperty('listType', listType))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('hasSubLists', hasSubLists))
      ..add(DiagnosticsProperty('featureImageUrl', featureImageUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListTypeModelImpl &&
            (identical(other.listType, listType) ||
                other.listType == listType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hasSubLists, hasSubLists) ||
                other.hasSubLists == hasSubLists) &&
            (identical(other.featureImageUrl, featureImageUrl) ||
                other.featureImageUrl == featureImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, listType, title, hasSubLists, featureImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListTypeModelImplCopyWith<_$ListTypeModelImpl> get copyWith =>
      __$$ListTypeModelImplCopyWithImpl<_$ListTypeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListTypeModelImplToJson(
      this,
    );
  }
}

abstract class _ListTypeModel implements ListTypeModel {
  const factory _ListTypeModel(
      {required final ListType listType,
      required final String title,
      final bool hasSubLists,
      required final String featureImageUrl}) = _$ListTypeModelImpl;

  factory _ListTypeModel.fromJson(Map<String, dynamic> json) =
      _$ListTypeModelImpl.fromJson;

  @override
  ListType get listType;
  @override
  String get title;
  @override
  bool get hasSubLists;
  @override
  String get featureImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$ListTypeModelImplCopyWith<_$ListTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

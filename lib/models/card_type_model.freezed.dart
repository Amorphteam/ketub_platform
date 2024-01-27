// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CardTypeModel _$CardTypeModelFromJson(Map<String, dynamic> json) {
  return _CardTypeModel.fromJson(json);
}

/// @nodoc
mixin _$CardTypeModel {
  CardType get cardType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get hasLoadMore => throw _privateConstructorUsedError;
  String get featureImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CardTypeModelCopyWith<CardTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardTypeModelCopyWith<$Res> {
  factory $CardTypeModelCopyWith(
          CardTypeModel value, $Res Function(CardTypeModel) then) =
      _$CardTypeModelCopyWithImpl<$Res, CardTypeModel>;
  @useResult
  $Res call(
      {CardType cardType,
      String title,
      bool hasLoadMore,
      String featureImageUrl});
}

/// @nodoc
class _$CardTypeModelCopyWithImpl<$Res, $Val extends CardTypeModel>
    implements $CardTypeModelCopyWith<$Res> {
  _$CardTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardType = null,
    Object? title = null,
    Object? hasLoadMore = null,
    Object? featureImageUrl = null,
  }) {
    return _then(_value.copyWith(
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as CardType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hasLoadMore: null == hasLoadMore
          ? _value.hasLoadMore
          : hasLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      featureImageUrl: null == featureImageUrl
          ? _value.featureImageUrl
          : featureImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardTypeModelImplCopyWith<$Res>
    implements $CardTypeModelCopyWith<$Res> {
  factory _$$CardTypeModelImplCopyWith(
          _$CardTypeModelImpl value, $Res Function(_$CardTypeModelImpl) then) =
      __$$CardTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CardType cardType,
      String title,
      bool hasLoadMore,
      String featureImageUrl});
}

/// @nodoc
class __$$CardTypeModelImplCopyWithImpl<$Res>
    extends _$CardTypeModelCopyWithImpl<$Res, _$CardTypeModelImpl>
    implements _$$CardTypeModelImplCopyWith<$Res> {
  __$$CardTypeModelImplCopyWithImpl(
      _$CardTypeModelImpl _value, $Res Function(_$CardTypeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardType = null,
    Object? title = null,
    Object? hasLoadMore = null,
    Object? featureImageUrl = null,
  }) {
    return _then(_$CardTypeModelImpl(
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as CardType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hasLoadMore: null == hasLoadMore
          ? _value.hasLoadMore
          : hasLoadMore // ignore: cast_nullable_to_non_nullable
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
class _$CardTypeModelImpl
    with DiagnosticableTreeMixin
    implements _CardTypeModel {
  const _$CardTypeModelImpl(
      {required this.cardType,
      required this.title,
      this.hasLoadMore = false,
      required this.featureImageUrl});

  factory _$CardTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardTypeModelImplFromJson(json);

  @override
  final CardType cardType;
  @override
  final String title;
  @override
  @JsonKey()
  final bool hasLoadMore;
  @override
  final String featureImageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CardTypeModel(cardType: $cardType, title: $title, hasLoadMore: $hasLoadMore, featureImageUrl: $featureImageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CardTypeModel'))
      ..add(DiagnosticsProperty('cardType', cardType))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('hasLoadMore', hasLoadMore))
      ..add(DiagnosticsProperty('featureImageUrl', featureImageUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardTypeModelImpl &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hasLoadMore, hasLoadMore) ||
                other.hasLoadMore == hasLoadMore) &&
            (identical(other.featureImageUrl, featureImageUrl) ||
                other.featureImageUrl == featureImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cardType, title, hasLoadMore, featureImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardTypeModelImplCopyWith<_$CardTypeModelImpl> get copyWith =>
      __$$CardTypeModelImplCopyWithImpl<_$CardTypeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardTypeModelImplToJson(
      this,
    );
  }
}

abstract class _CardTypeModel implements CardTypeModel {
  const factory _CardTypeModel(
      {required final CardType cardType,
      required final String title,
      final bool hasLoadMore,
      required final String featureImageUrl}) = _$CardTypeModelImpl;

  factory _CardTypeModel.fromJson(Map<String, dynamic> json) =
      _$CardTypeModelImpl.fromJson;

  @override
  CardType get cardType;
  @override
  String get title;
  @override
  bool get hasLoadMore;
  @override
  String get featureImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$CardTypeModelImplCopyWith<_$CardTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

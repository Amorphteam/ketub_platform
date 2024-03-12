// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardTypeModelImpl _$$CardTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$CardTypeModelImpl(
      cardType: $enumDecode(_$CardTypeEnumMap, json['cardType']),
      title: json['title'] as String,
      hasLoadMore: json['hasLoadMore'] as bool? ?? false,
      featureImageUrl: json['featureImageUrl'] as String,
      articles: (json['articles'] as List<dynamic>)
          .map(ArticleModel.fromJson)
          .toList(),
      slideOnline: (json['slideOnline'] as List<dynamic>?)
          ?.map((e) => SlideOnline.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CardTypeModelImplToJson(_$CardTypeModelImpl instance) =>
    <String, dynamic>{
      'cardType': _$CardTypeEnumMap[instance.cardType]!,
      'title': instance.title,
      'hasLoadMore': instance.hasLoadMore,
      'featureImageUrl': instance.featureImageUrl,
      'articles': instance.articles,
      'slideOnline': instance.slideOnline,
    };

const _$CardTypeEnumMap = {
  CardType.oneList: 'oneList',
  CardType.gridLarge: 'gridLarge',
  CardType.gridSmall: 'gridSmall',
  CardType.dynamicBanner: 'dynamicBanner',
  CardType.staticBanner: 'staticBanner',
};

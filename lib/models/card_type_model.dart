import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ketub_platform/models/slie_online.dart';

import 'article_model.dart';

part 'card_type_model.freezed.dart';
part 'card_type_model.g.dart';

@freezed
class CardTypeModel with _$CardTypeModel {
  const factory CardTypeModel({
    required CardType cardType,
    required String title,
    @Default(false) bool hasLoadMore,
    required String featureImageUrl,
    required List<ArticleModel> articles,
    List<SlideOnline>? slideOnline,
  }) = _CardTypeModel;

  factory CardTypeModel.fromJson(Map<String, dynamic> json) => _$CardTypeModelFromJson(json);
}


enum CardType {
  oneList,
  gridLarge,
  gridSmall,
  dynamicBanner,
  staticBanner,
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnlineSearchResultsImpl _$$OnlineSearchResultsImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlineSearchResultsImpl(
      categories: (json['categories'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map(Category.fromJson).toList()),
      ),
      count: json['count'] as int?,
      posts: (json['posts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, (e as List<dynamic>).map(ArticleModel.fromJson).toList()),
      ),
    );

Map<String, dynamic> _$$OnlineSearchResultsImplToJson(
        _$OnlineSearchResultsImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'count': instance.count,
      'posts': instance.posts,
    };

import 'package:freezed_annotation/freezed_annotation.dart';

import 'article_model.dart';
part 'online_search_results.freezed.dart';
part 'online_search_results.g.dart';

@freezed
class OnlineSearchResults with _$OnlineSearchResults {
  const factory OnlineSearchResults({
    Map<String, List<Category>>? categories,
    int? count,
    Map<String, List<ArticleModel>>? posts,
  }) = _OnlineSearchResults;

  factory OnlineSearchResults.fromJson(Map<String, dynamic> json) => _$OnlineSearchResultsFromJson(json);
}

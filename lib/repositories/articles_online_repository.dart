import 'dart:convert';

import 'package:ketub_platform/models/article_list.dart';
import 'package:ketub_platform/models/article_model.dart';
import 'package:http/http.dart' as http;


class ArticleOnlineRepository{
  final String apiUrl = 'https://api.hobbollah.com:8888/';
  Future<ArticleModel> getArticles(int tag) async {
    String pathUrl = 'api/v1/article/view/$tag';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ArticleModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ArticleList> getArticlesList(int limit, int offset, String catName) async {
    String pathUrl = 'api/v1/article/$catName';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ArticleList.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ArticleList> getArticlesListFromCatId(int limit, int offset, String catId) async {
    String pathUrl = 'api/v1/article/list/$catId';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ArticleList.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
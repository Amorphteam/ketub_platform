import 'dart:convert';

import 'package:ketub_platform/models/online_search_results.dart';
import 'package:ketub_platform/models/slie_online.dart';
import 'package:ketub_platform/models/tree_cat.dart';
import 'package:http/http.dart' as http;

import '../models/article_list.dart';
import '../models/article_model.dart';

class OnlineRepository {
  final String apiUrl = 'https://api.hobbollah.com:8888/';

  Future<TreeCat> getTreeCat(String catName) async {
    String pathUrl = 'api/v1/category/$catName';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return TreeCat.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }


  Future<ArticleModel> getArticles(int tag) async {
    String pathUrl = 'api/v1/article/view/$tag';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ArticleModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ArticleList> getArticlesList(int limit, int offset,
      String catName) async {
    String pathUrl = 'api/v1/article/$catName';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ArticleList.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ArticleList> getArticlesListFromCatId(int limit, int offset,
      String catId) async {
    String pathUrl = 'api/v1/article/list/$catId';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ArticleList.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }


  Future<OnlineSearchResults> getSearchResults(String query) async {
    String pathUrl = 'api/v1/article/search?search=$query';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return OnlineSearchResults.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }


  Future<List<SlideOnline>> getSlideOnline() async {
    String pathUrl = 'api/v1/slide';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => SlideOnline.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch data with status code ${response.statusCode}');
    }
  }
}
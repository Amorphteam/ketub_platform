import 'dart:convert';

import 'package:ketub_platform/models/Article_model.dart';
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
}
import 'dart:convert';

import 'package:ketub_platform/models/tree_cat.dart';
import 'package:http/http.dart' as http;

class CatOnlineRepository {
  final String apiUrl = 'https://api.hobbollah.com:8888/';
  Future<TreeCat> getTreeCat(String catName) async {
    String pathUrl = 'api/v1/category/$catName';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return TreeCat.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

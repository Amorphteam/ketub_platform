import '../models/audio_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AudioOnlineRepository{

  final String apiUrl = 'https://api.hobbollah.com:8888/';
  Future<AudioModel> getArticles(int tag) async {
    String pathUrl = 'api/v1/article/view/$tag';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return AudioModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

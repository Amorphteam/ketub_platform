import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../models/card_type_model.dart';
import '../models/list_type_model.dart';
import '../repositories/articles_online_repository.dart';

class DataHelper{



  static List<ListTypeModel> list = [
    ListTypeModel(listType: ListType.gridList, title: 'آراء', featureImageUrl: 'assets/images/bk1.jpg'),
  ];

  static int _nextMediaId = 0;

  static ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
      Uri.parse(
          "https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/097.MP3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/095.MP3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/095.MP3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Public Domain",
        title: "Nature Sounds",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/095.MP3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Public Domain",
        title: "Nature Sounds",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/095.MP3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Public Domain",
        title: "Nature Sounds",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
  ]);
  static Map<String, String> categories = {
    'المقالات': 'articles',
    'المحاضرات': 'mohazerat',
    'الحوارات': 'hewarat',
    'آراء': 'araa',
    'الأسئلة والأجوبة': 'questions',
    'كلمات ومواقف': 'qesar',
    'متابعات': 'motabeat',
    'لغات أخرى': 'nonarabic',
  };
}
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../models/card_type_model.dart';
import '../models/list_type_model.dart';

class DataHelper{
  static List<CardTypeModel> cards = [
    CardTypeModel(cardType: CardType.gridLarge, title: 'المحاضرات', hasLoadMore: true, featureImageUrl: 'assets/images/bk1.jpg'),
    CardTypeModel(cardType: CardType.oneList, title: 'الصوتيات', hasLoadMore: true, featureImageUrl: 'assets/images/bk2.jpg'),
    CardTypeModel(cardType: CardType.gridSmall, title: 'الكتب', hasLoadMore: true, featureImageUrl: 'assets/images/bk3.jpg'),
    CardTypeModel(cardType: CardType.dynamicBanner, title: 'الكتب', hasLoadMore: true, featureImageUrl: 'assets/images/bk3.jpg'),
    CardTypeModel(cardType: CardType.gridLarge, title: 'المحاضرات', hasLoadMore: true , featureImageUrl: 'assets/images/bk1.jpg'),
    CardTypeModel(cardType: CardType.staticBanner, title: 'المحاضرات', hasLoadMore: true, featureImageUrl: 'assets/images/bk4.jpg'),
    CardTypeModel(cardType: CardType.gridSmall, title: 'الكتب', hasLoadMore: true, featureImageUrl: 'assets/images/bk3.jpg'),
    CardTypeModel(cardType: CardType.gridLarge, title: 'المحاضرات', hasLoadMore: true, featureImageUrl: 'assets/images/bk1.jpg'),
  ];

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

}
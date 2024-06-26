import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ketub_platform/utils/data_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/card_type_model.dart';
import '../../../../models/slie_online.dart';
import '../../../../repositories/online_repository.dart';

part 'home_all_cat_state.dart';

part 'home_all_cat_cubit.freezed.dart';

class HomeAllCatCubit extends Cubit<HomeAllCatState> {
  HomeAllCatCubit() : super(const HomeAllCatState.initial());


  Future<void> loadCards() async {
    try {
      emit(const HomeAllCatState.loading());
      final prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString('cachedCardList');

      if (cachedData != null) {
        // Load from cache
        List<dynamic> cachedList = jsonDecode(cachedData);
        List<CardTypeModel> cards = cachedList
            .map((jsonCard) => CardTypeModel.fromJson(jsonCard))
            .toList();
        emit(HomeAllCatState.loaded(cardList: cards));
      } else {
        // Load from network
        List<CardTypeModel> cards = await _fetchCardsFromNetwork();
        // Cache the data
        prefs.setString('cachedCardList', jsonEncode(cards.map((card) => card.toJson()).toList()));
        emit(HomeAllCatState.loaded(cardList: cards));
      }
    } catch (e) {
      emit(HomeAllCatState.error(e.toString()));
    }
  }

  Future<List<CardTypeModel>> _fetchCardsFromNetwork() async {
    List<CardTypeModel> cards = [];
    List<Future<void>> futures = [];

    DataHelper.categories.forEach((key, value) {
      futures.add(
        OnlineRepository()
            .getArticlesList(6, 0, value)
            .then((articlesList) {
          cards.add(CardTypeModel(
            cardType: getCardType(title: value),
            title: key,
            hasLoadMore: true,
            featureImageUrl: getFeatureImage(title: value),
            articles: articlesList.posts!,
          ));
        }),
      );
    });
    futures.add(addBannerToList(cards));

    await Future.wait(futures);
    reorderTheList(cards);
    return cards;
  }


  Future<void> addBannerToList(List<CardTypeModel> cards) async {
    cards.add(const CardTypeModel(cardType: CardType.staticBanner, title: 'الإعلانات٢', featureImageUrl: '', articles: []));

    var banners = await OnlineRepository().getSlideOnline();
    cards.add(CardTypeModel(
        cardType: CardType.dynamicBanner,
        title: 'الإعلانات',
        featureImageUrl: '',
        articles: [],
        slideOnline: banners
    ));

  }


  void reorderTheList(List<CardTypeModel> cards) {
    List<String> orderOfTitles = [
      'المحاضرات',
      'المقالات',
      'الإعلانات',
      'الحوارات',
      'آراء',
      'الأسئلة والأجوبة',
      'الإعلانات٢',
      'كلمات ومواقف',
      'لغات أخرى',
      'متابعات',
    ];
    cards.sort((a, b) => orderOfTitles
        .indexOf(a.title)
        .compareTo(orderOfTitles.indexOf(b.title)));
  }

  String getFeatureImage({required String title}) {
    switch (title) {
      case 'mohazerat':
        return 'assets/images/bk4.jpg';
      case 'articles':
        return 'assets/images/bk2.jpg';
      case 'nonarabic':
        return 'assets/images/bk1.jpg';
      case 'araa':
        return 'assets/images/bk3.jpg';
      case 'questions':
        return 'assets/images/bk5.jpg';
      case 'hewarat':
        return 'assets/images/bk6.jpg';
      case 'qesar':
        return 'assets/images/bk6.jpg';
      default:
        return 'assets/images/bk3.jpg';
    }
  }

  getCardType({required String title}) {
    switch (title) {
      case 'mohazerat':
        return CardType.oneList;
      case 'articles':
        return CardType.gridLarge;
      case 'nonarabic':
        return CardType.gridSmall;
      case 'araa':
        return CardType.gridLarge;
      case 'questions':
        return CardType.gridSmall;
      case 'hewarat':
        return CardType.gridSmall;
      default:
        return CardType.gridLarge;
    }
  }
}

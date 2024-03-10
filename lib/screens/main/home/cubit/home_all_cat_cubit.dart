import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../../../models/card_type_model.dart';
import '../../../../repositories/articles_online_repository.dart';

part 'home_all_cat_state.dart';

part 'home_all_cat_cubit.freezed.dart';

class HomeAllCatCubit extends Cubit<HomeAllCatState> {
  HomeAllCatCubit() : super(const HomeAllCatState.initial());

  Future<void> loadCards() async {
    try {
      emit(const HomeAllCatState.loading());
      List<CardTypeModel> cards = [];
      List<Future<void>> futures = [];

      DataHelper.categories.forEach((key, value) {
        // Collect futures of async operations
        futures.add(
          ArticleOnlineRepository()
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

      // Wait for all futures to complete
      await Future.wait(futures);
      addBannerToList(cards);
      reorderTheList(cards);
      emit(HomeAllCatState.loaded(cardList: cards));
    } catch (e) {
      emit(HomeAllCatState.error(e.toString()));
    }
  }

  void addBannerToList(List<CardTypeModel> cards) {
    cards.add(CardTypeModel(cardType: CardType.dynamicBanner, title: 'الإعلانات', featureImageUrl: '', articles: []));
    cards.add(CardTypeModel(cardType: CardType.staticBanner, title: 'الإعلانات٢', featureImageUrl: '', articles: []));
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

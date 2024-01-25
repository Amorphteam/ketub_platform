import '../models/card_type_model.dart';

class HomeHelper{
  static List<CardTypeModel> cards = [
    CardTypeModel(cardType: CardType.gridLarge, title: 'المحاضرات', hasLoadMore: true, featureImageUrl: 'assets/images/bk1.jpg'),
    CardTypeModel(cardType: CardType.oneList, title: 'الصوتيات', hasLoadMore: true, featureImageUrl: 'assets/images/bk2.jpg'),
    CardTypeModel(cardType: CardType.gridSmall, title: 'الكتب', hasLoadMore: true, featureImageUrl: 'assets/images/bk3.jpg'),
    CardTypeModel(cardType: CardType.gridLarge, title: 'المحاضرات', hasLoadMore: true, featureImageUrl: 'assets/images/bk4.jpg'),
    CardTypeModel(cardType: CardType.gridLarge, title: 'المحاضرات', hasLoadMore: true , featureImageUrl: 'assets/images/bk1.jpg'),
  ];
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/models/card_type_model.dart';
import 'package:ketub_platform/screens/main/home/widgets/section_card_widget.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../search/search_screen.dart';

class homeAllCatScreen extends StatefulWidget {
  const homeAllCatScreen({super.key});

  @override
  State<homeAllCatScreen> createState() => _homeAllCatScreenState();
}

class _homeAllCatScreenState extends State<homeAllCatScreen> {
  List<CardTypeModel>? cards;
  @override
  void initState() {
    cards = DataHelper.cards;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: cards?.length,
          itemBuilder: (context, index) {
            return SectionCardWidget(cardType: cards?[index].cardType ?? CardType.gridLarge, title: cards?[index].title ?? '', hasLoadMore: cards?[index].hasLoadMore ?? false, featureImageUrl: cards?[index].featureImageUrl ?? 'assets/images/bk1.jpg',);
          }),
    );
  }
}

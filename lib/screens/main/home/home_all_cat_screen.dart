import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/models/card_type_model.dart';
import 'package:ketub_platform/screens/main/home/cubit/home_all_cat_cubit.dart';
import 'package:ketub_platform/screens/main/home/widgets/section_card_widget.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../search/search_screen.dart';
import '../no_internet_tab/no_internet_screen.dart';

class homeAllCatScreen extends StatefulWidget {
  const homeAllCatScreen({super.key});

  @override
  State<homeAllCatScreen> createState() => _homeAllCatScreenState();
}

class _homeAllCatScreenState extends State<homeAllCatScreen> {
  @override
  void initState() {
    super.initState();
    loadCards();
  }

  void loadCards() {
    BlocProvider.of<HomeAllCatCubit>(context).loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeAllCatCubit, HomeAllCatState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initial State')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: _buildErrorScreen()),
            loaded: (cards) => _buildCardsList(cards),
          );
        },
      ),
    );
  }

  _buildCardsList(List<CardTypeModel> cards) {
    return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return SectionCardWidget(
            posts: cards[index].articles,
            cardType: cards[index].cardType,
            title: cards[index].title,
            hasLoadMore: cards[index].hasLoadMore,
            featureImageUrl: cards[index].featureImageUrl,
            slides: cards[index].slideOnline,
          );
        });
  }

  _buildErrorScreen() {
    return NoInternetScreen(
      retry: () {
        print('Retry Clicked');
        loadCards();
      },
    );
  }
}

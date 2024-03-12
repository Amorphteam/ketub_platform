import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/articelType.dart';
import 'package:ketub_platform/models/card_type_model.dart';
import 'package:ketub_platform/screens/audio/audio_screen.dart';
import 'package:ketub_platform/screens/audio/cubit/audio_player_cubit.dart';
import 'package:ketub_platform/screens/category_list/category_list_screen.dart';
import 'package:ketub_platform/screens/category_list/cubit/category_list_cubit.dart';
import 'package:ketub_platform/screens/html_viewer/cubit/html_viewer_cubit.dart';
import 'package:ketub_platform/screens/html_viewer/html_viewer_screen.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../../../models/article_model.dart';
import 'grid_item_widget.dart';
import 'image_slider_widget.dart';

class SectionCardWidget extends StatefulWidget {
  final CardType cardType;
  final String title;
  final bool hasLoadMore;
  final String featureImageUrl;
  final List<ArticleModel> posts;

  const SectionCardWidget({super.key,
    required this.posts,
    required this.cardType,
    required this.title,
    required this.hasLoadMore,
    required this.featureImageUrl});

  @override
  State<SectionCardWidget> createState() => _SectionCardWidgetState();
}

class _SectionCardWidgetState extends State<SectionCardWidget> {
  var containerHeight = 420.0;
  var childRatio = 0.3;
  var itemHeight = 80.0;
  var itemWidth = 80.0;
  var insideTitlePosition = true;
  var withTitle = true;
  var maxCrossAxisExtent = 120.0;

  @override
  void initState() {
    super.initState();
    handleCardType(widget.cardType);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.cardType) {
      case CardType.staticBanner:
        return buildImageBanner(context);
      case CardType.dynamicBanner:
        return buildDynamicBanner(context);
      default:
        return buildGridView(context);
    }
  }

  Widget buildGridView(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,
                ),
                if (widget.hasLoadMore)
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/load_more.svg'),
                    onPressed: () {
                      _openCategoryScreen(catName: widget.title);
                    },
                  ),
              ],
            ),
          ),

          // GridView section
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtent,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: childRatio,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    DataHelper.openDetailScreen(context, widget.posts[index]);
                  },
                  child: GridItemWidget(
                    title: widget.posts[index].name ?? '',
                    imagePath: widget.featureImageUrl,
                    height: itemHeight,
                    width: itemWidth,
                    insideTitlePosition: insideTitlePosition,
                    withTitle: withTitle,
                    isAudio: widget.posts[index].mediaDownloadLink != null &&
                        widget.posts[index].mediaDownloadLink != '',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleCardType(CardType cardType) {
    switch (cardType) {
      case CardType.gridLarge:
        containerHeight = 400;
        childRatio = 0.3;
        itemHeight = 80.0;
        itemWidth = 80.0;
        break;
      case CardType.oneList:
        containerHeight = 250;
        childRatio = 1.6;
        maxCrossAxisExtent = 200;
        itemHeight = 80.0;
        itemWidth = 80.0;
        insideTitlePosition = false;
        break;
      case CardType.gridSmall:
        containerHeight = 260;
        childRatio = 0.4;
        itemHeight = 30.0;
        itemWidth = 30.0;
        break;
      case CardType.dynamicBanner:
        break;
      case CardType.staticBanner:
        break;
    }
  }

  Widget buildImageBanner(BuildContext context) {
    return Image.asset('assets/images/instagram_add.jpg', fit: BoxFit.cover);
  }

  Widget buildDynamicBanner(BuildContext context) {
    return Container(height: 200, child: ImageSliderWidget());
  }

  _openCategoryScreen({required String catName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BlocProvider(
              create: (context) => CategoryListCubit(),
              child: CategoryListScreen(catName: catName),
            ),
      ),
    );
  }


}


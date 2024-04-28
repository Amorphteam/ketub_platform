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
import 'package:lottie/lottie.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/article_model.dart';
import '../../../../models/slie_online.dart';
import 'grid_item_widget.dart';
import 'image_slider_widget.dart';

class SectionCardWidget extends StatefulWidget {
  final CardType cardType;
  final String title;
  final bool hasLoadMore;
  final String featureImageUrl;
  final List<ArticleModel> posts;
  final List<SlideOnline>? slides;

  const SectionCardWidget(
      {super.key,
      required this.posts,
      required this.cardType,
      required this.title,
      required this.hasLoadMore,
      required this.featureImageUrl,
      this.slides});

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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (widget.hasLoadMore)
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/load_more.svg',
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
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
    return GestureDetector(
      onTap: _sendEmailToAmorph,
      child: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Lottie.asset(
                'assets/jsons/amorph.json',
                repeat: false,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  children: [
                    Text(
                      'Amorph',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.right, // Align text to the right
                    ),
                    Text(
                      'لتصميم تطبيق مشابه، اتصل بنا',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.right, // Align text to the right
                    ),
                  ],
                ),
              ),
              bottom: 50,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDynamicBanner(BuildContext context) {
    return Container(
        height: 170,
        child: ImageSliderWidget(
          slides: widget.slides,
        ));
  }

  _openCategoryScreen({required String catName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => CategoryListCubit(),
          child: CategoryListScreen(catName: catName),
        ),
      ),
    );
  }

  void _sendEmailToAmorph() async {
    final mailtoLink = Mailto(
      to: ['amorphteam@gmail.com'],
      bcc: ['johar.ali1@gmail.com'],
      subject: 'New App from hobbollah app',
      body: 'I am interested in creating a new app.',
    );

    // Convert the Mailto instance into a string URL.
    final urlString = mailtoLink.toString();

    // Use url_launcher to launch the mail app.
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}

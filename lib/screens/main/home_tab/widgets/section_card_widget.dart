import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/card_type_model.dart';
import 'package:ketub_platform/screens/main/home_tab/widgets/grid_item_widget.dart';

class SectionCardWidget extends StatefulWidget {
  final CardType cardType;
  final String title;
  final bool hasLoadMore;
  final String featureImageUrl;

  const SectionCardWidget({super.key, required this.cardType, required this.title, required this.hasLoadMore, required this.featureImageUrl});

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
    return SizedBox(
      height: containerHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 46, right: 16, left: 16),
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
                    // Handle more info action
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
                return GridItemWidget(
                  title: 'قاعدة اللطف في التفكير المعتزلي وأتباعه ـ قراءة تحليلية وكشف لمكامن الضعف التطبيقي $index',
                  // Replace with actual title
                  imagePath: widget.featureImageUrl,
                  height: itemHeight,
                  width: itemWidth,
                  insideTitlePosition: insideTitlePosition,
                  withTitle: withTitle,
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
        containerHeight = 420;
        childRatio = 0.3;
        itemHeight = 80.0;
        itemWidth = 80.0;
        break;
      case CardType.oneList:
        containerHeight = 270;
        childRatio = 1.5;
        maxCrossAxisExtent = 200;
        itemHeight = 80.0;
        itemWidth = 80.0;
        insideTitlePosition = false;
        break;
      case CardType.gridSmall:
        containerHeight = 320;
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
}
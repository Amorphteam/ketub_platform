import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/screens/main/home_tab/widgets/grid_item_widget.dart';

class SectionCardWidget extends StatelessWidget {
  const SectionCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 46, right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                Text(
                  'المحاضرات',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
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
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120, // Height of each item, adjust as needed.
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.3, // The aspect ratio of the items in the grid.
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GridItemWidget(
                  title: 'قاعدة اللطف في التفكير المعتزلي وأتباعه ـ قراءة تحليلية وكشف لمكامن الضعف التطبيقي $index', // Replace with actual title
                  imagePath: 'assets/images/bk1.jpg', // Replace with actual image path
                );
              },
            ),
          ),
        ],
      ),
    );

}
}

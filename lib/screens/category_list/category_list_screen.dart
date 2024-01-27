import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketub_platform/models/list_type_model.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../main/home/widgets/grid_item_widget.dart';

class CategoryListScreen extends StatefulWidget {

  CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<ListTypeModel>? list;

  @override
  void initState() {
    super.initState();
    list = DataHelper.list;
  }

  @override
  Widget build(BuildContext context) {
    return _buildUi(list?[0].listType ?? ListType.simpleList);
  }

  _buildUi(ListType listType) {
    switch (listType) {
      case ListType.gridList:
        return Scaffold(
            appBar: AppBar(
              title: Text(list?[0].title ?? ''),
            ),
            body: buildGridView());
      case ListType.simpleList:
        return Scaffold(
            appBar: AppBar(
              title: Text(list?[0].title ?? ''),
            ),
            body: buildListView());
    }
  }

  Widget buildListView() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 5,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        return GridItemWidget(
          title:
          'قاعدة اللطف في التفكير المعتزلي وأتباعه ـ قراءة تحليلية وكشف لمكامن الضعف التطبيقي $index',
          imagePath: list?[0].featureImageUrl ?? '',
          height: 60,
          width: 60,
          insideTitlePosition: true,
          withTitle: true,
          withBk: true,
        );
      },
);

  }

  Widget buildGridView() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Set the number of columns to 3
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1, // Adjust the aspect ratio if needed
      ),
      itemCount: 60,
      itemBuilder: (context, index) {
        return GridItemWidget(
          title: 'قاعدة اللطف في التفكير المعتزلي وأتباعه ـ قراءة تحليلية وكشف لمكامن الضعف التطبيقي $index',
          imagePath: list?[0].featureImageUrl ?? '',
          height: 80,
          width: 80,
          insideTitlePosition: false,
          withTitle: true,
        );
      },
    );
  }
}

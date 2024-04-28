import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/tree_cat.dart'; // Make sure this import is correct
import 'package:ketub_platform/repositories/online_repository.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../category_list/category_list_screen.dart';
import '../../category_list/cubit/category_list_cubit.dart';
import 'cubit/home_tree_cat_cubit.dart';

class HomeTreeCatScreen extends StatefulWidget {
  @override
  State<HomeTreeCatScreen> createState() => _HomeTreeCatScreenState();
}

class _HomeTreeCatScreenState extends State<HomeTreeCatScreen> {
  late Future<List<Category>> combinedCategoriesFuture;

  @override
  void initState() {
    super.initState();
    context.read<HomeTreeCatCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTreeCatCubit, HomeTreeCatState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (categories) => ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) => buildTreeNode(categories[index], 0, context, isRoot: true),
          ),
          error: (message) => Text("Error: $message"),
        );
      },
    );
  }


  _openCategoryScreen({required String catId, String? catName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BlocProvider(
              create: (context) => CategoryListCubit(),
              child: CategoryListScreen(catId: catId, catName: catName),
            ),
      ),
    );
  }

  Widget buildTreeNode(Category node, int level, BuildContext context, {bool isRoot = false}) {
    const maxLevel = 5;
    const minFontSize = 10.0;
    const maxFontSize = 18.0;
    const minPadding = 0.0;
    const maxPadding = 40.0;

    double padding = minPadding + (maxPadding - minPadding) / maxLevel * level;
    double fontSize = maxFontSize - (maxFontSize - minFontSize) / maxLevel * level;
    Color backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5);

    bool hasChildren = node.children != null && node.children!.isNotEmpty;

    Widget titleWidget = Container(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Center(
              child: Container(
                width: 10,
                height: 50,
                color: isRoot ? backgroundColor : Colors.transparent,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: padding),
              child: ListTile(
                title: Text(
                  node.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSize),
                ),
                onTap: hasChildren ? null : () {
                  _openCategoryScreen(catId: node.id.toString(), catName: node.name);
                },
              ),
            ),
          ),
        ],
      ),
    );

    if (!hasChildren) {
      return titleWidget;
    }

    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: titleWidget,
        children: node.children!
            .map((child) => buildTreeNode(child, level + 1, context))
            .toList(),
      ),
    );
  }
}

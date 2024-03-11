import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/tree_cat.dart'; // Make sure this import is correct
import 'package:ketub_platform/repositories/cat_online_repository.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../category_list/category_list_screen.dart';
import '../../category_list/cubit/category_list_cubit.dart';

class HomeTreeCatScreen extends StatefulWidget {
  @override
  State<HomeTreeCatScreen> createState() => _HomeTreeCatScreenState();
}

class _HomeTreeCatScreenState extends State<HomeTreeCatScreen> {
  late Future<List<Category>> combinedCategoriesFuture;

  @override
  void initState() {
    super.initState();
    combinedCategoriesFuture = _getCombinedCategories();
  }

  Future<List<Category>> _getCombinedCategories() async {
    List<Category> combinedCategories = [];

    for (var entry in DataHelper.categories.entries) {
      var treeCat = await CatOnlineRepository().getTreeCat(entry.value);
      combinedCategories.add(
          Category(name: entry.key, children: treeCat.categories));
    }

    return combinedCategories;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: combinedCategoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return buildTreeNode(snapshot.data![index], 0, context);
            },
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
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

  Widget buildTreeNode(Category node, int level, BuildContext context) {
    // Constants for tree styling
    const maxLevel = 5;
    const minFontSize = 10.0;
    const maxFontSize = 18.0;
    const minPadding = 0.0;
    const maxPadding = 40.0;

    double padding = minPadding + (maxPadding - minPadding) / maxLevel * level;
    double fontSize = maxFontSize - (maxFontSize - minFontSize) / maxLevel * level;

    bool hasChildren = node.children != null && node.children!.isNotEmpty;

    if (!hasChildren) {
      return Padding(
        padding: EdgeInsets.only(right: padding),
        child: ListTile(
          title: Text(
            node.name ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSize),
          ),
          onTap: () {
            _openCategoryScreen(catId: node.id.toString(), catName: node.name);
          },
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: padding),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            node.name ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSize),
          ),
          children: node.children!.map((child) => buildTreeNode(child, level + 1, context)).toList(),
        ),
      ),
    );
  }
}

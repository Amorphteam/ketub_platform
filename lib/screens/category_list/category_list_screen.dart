import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/list_type_model.dart';
import 'package:ketub_platform/models/tree_cat.dart';
import 'package:ketub_platform/screens/category_list/cubit/category_list_cubit.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../models/article_list.dart';
import '../main/home/widgets/grid_item_widget.dart';

class CategoryListScreen extends StatefulWidget {
  final String? catName;
  final String? catId;

  CategoryListScreen({super.key, this.catName, this.catId});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  String? selectedCatId;
  TreeCat? treeCat;

  @override
  void initState() {
    super.initState();
    if (widget.catId != null) {
      context.read<CategoryListCubit>().loadArticlesList(catId: widget.catId);
    } else {
      String? catNameUrl = getCatNameUrl(widget.catName ?? '');
      context
          .read<CategoryListCubit>()
          .loadTreeCats(sectionName: catNameUrl ?? '');
      context
          .read<CategoryListCubit>()
          .loadArticlesList(catNameUrl: catNameUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName ?? ''),
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryListCubit, CategoryListState>(
            builder: (context, state) {
              return state.maybeWhen(
                treeCat: (treeCat) {
                  this.treeCat = treeCat;
                  return _buildCategoryChips(treeCat.categories);
                },
                orElse: () {
                  return _buildCategoryChips(treeCat?.categories);
                },
              );
            },
          ),
          Expanded(
            child: BlocBuilder<CategoryListCubit, CategoryListState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (articles) => _buildUi(context, articles),
                  orElse: () => Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(List<Category>? categories) {
    if (categories == null || categories.isEmpty) {
      // Return an empty container when there are no categories
      return SizedBox.shrink();
    }

    List<Widget> chips = [];
    for (var category in categories) {
      _getLastLevelCategories(category, chips);
    }

    return Container(
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: chips,
      ),
    );
  }

  void _getLastLevelCategories(Category category, List<Widget> chips) {
    if (category.children == null || category.children!.isEmpty) {
      bool isSelected = selectedCatId == category.id.toString();
      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          label: Text(category.name ?? ''),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              selectedCatId = selected ? category.id.toString() : null;
            });
            if (selectedCatId != null) {
              context
                  .read<CategoryListCubit>()
                  .loadArticlesList(catId: selectedCatId);
            }
          },
        ),
      ));
    } else {
      for (var child in category.children!) {
        _getLastLevelCategories(child, chips);
      }
    }
  }

  Widget _buildUi(BuildContext context, ArticleList? articles) {
    if (articles != null &&
        articles.posts != null &&
        articles.posts!.isNotEmpty) {
      if (articles.posts?[0].mediaDownloadLink != '') {
        return buildGridView(articles);
      } else {
        return buildListView(articles);
      }
    } else {
      return Center(child: Text('No articles found'));
    }
  }

  Widget buildGridView(ArticleList? articles) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: articles?.posts?.length,
      itemBuilder: (context, index) {
        var article = articles?.posts?[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              DataHelper.openDetailScreen(context, articles?.posts?[index]);
            },
            child: GridItemWidget(
              title: article?.name ?? '',
              imagePath: 'assets/images/bk4.jpg',
              height: 80,
              width: 80,
              insideTitlePosition: false,
              withTitle: true,
              isAudio: articles?.posts?[index].mediaDownloadLink != '',
            ),
          ),
        );
      },
    );
  }

  Widget buildListView(ArticleList articles) {
    return ListView.builder(
        itemCount: articles.posts?.length,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          var article = articles.posts?[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                DataHelper.openDetailScreen(context, articles.posts![index]);
              },
              child: GridItemWidget(
                title: article?.name ?? '',
                imagePath: 'assets/images/bk3.jpg',
                height: 50,
                width: 50,
                insideTitlePosition: true,
                withTitle: true,
                withBk: true,
                isAudio: articles?.posts?[index].mediaDownloadLink != '',
              ),
            ),
          );
        });
  }

  String? getCatNameUrl(String catName) {
    return DataHelper.categories[catName];
  }
}

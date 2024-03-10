import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/list_type_model.dart';
import 'package:ketub_platform/screens/category_list/cubit/category_list_cubit.dart';
import 'package:ketub_platform/utils/data_helper.dart';

import '../../models/article_list.dart';
import '../main/home/widgets/grid_item_widget.dart';

class CategoryListScreen extends StatefulWidget {
  final String catName;
  CategoryListScreen({super.key, required this.catName});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<ListTypeModel>? list;

  @override
  void initState() {
    super.initState();
    String? catNameUrl = getCatNameUrl(widget.catName);
    context.read<CategoryListCubit>().loadArticlesList(catNameUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName),
      ),
      body: BlocBuilder<CategoryListCubit, CategoryListState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Select a category')),
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (articles) => _buildUi(context, articles), // Pass the articles to the UI builder
            error: (error) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }

  Widget _buildUi(BuildContext context, ArticleList articles) {
    return articles.posts?[0].mediaDownloadLink != ''  ? buildGridView(articles) : buildListView(articles);
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
            onTap: (){
              DataHelper.openDetailScreen(context, articles.posts![index]);
            },
            child: GridItemWidget(
              title: article?.name ?? '',
              imagePath: 'assets/images/bk2.jpg',
              height: 60,
              width: 60,
              insideTitlePosition: true,
              withTitle: true,
              withBk: true,
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView(ArticleList articles) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: articles.posts?.length,
      itemBuilder: (context, index) {
        var article = articles.posts?[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              DataHelper.openDetailScreen(context, articles.posts![index]);
            },
            child: GridItemWidget(
              title: article?.name ?? '',
              imagePath: 'assets/images/bk2.jpg',
              height: 80,
              width: 80,
              insideTitlePosition: false,
              withTitle: true,
            ),
          ),
        );
      },
    );
  }

  String? getCatNameUrl(String catName) {
    return DataHelper.categories[catName];
  }
}

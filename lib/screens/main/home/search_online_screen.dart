import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/online_search_results.dart';
import 'package:ketub_platform/screens/main/home/cubit/search_online_cubit.dart';

import '../../../utils/data_helper.dart';
import '../shared_widgets/search_bar_widget.dart';

class SearchOnlineScreen extends StatefulWidget {
  String query = '';

  SearchOnlineScreen({super.key, required this.query});

  @override
  State<SearchOnlineScreen> createState() => _SearchOnlineScreenState();
}

class _SearchOnlineScreenState extends State<SearchOnlineScreen> {
  @override
  void initState() {
    super.initState();
    startSearch(widget.query);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: SearchBarWiget(query: widget.query,onClicked: startSearch),
      ),
      body: BlocBuilder<SearchOnlineCubit, SearchOnlineState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Start your search')),
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (onlineSearchResults) => _buildSearchResult(context, onlineSearchResults),
            error: (error) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }

  Widget _buildSearchResult(BuildContext context, OnlineSearchResults onlineSearchResults) {
    double itemHeight = 150;
    double itemWidth = 150;

    // Assuming posts are stored in a flat list for simplicity
    var posts = onlineSearchResults.posts?.entries.expand((entry) => entry.value).toList() ?? [];

    return GridView.builder(
      padding: EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisSpacing: 8, // Spacing between columns
        mainAxisSpacing: 8, // Spacing between rows
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final category = onlineSearchResults.categories?[post.categoryId.toString()]?.first.name ?? 'Category';

        return GestureDetector(
          onTap: (){
            DataHelper.openDetailScreen(context, posts[index]);
          },
          child: Column(
            children: [
              Expanded(
                child: Card(
                  elevation: 0.0,
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 10),
                    child: Text(
                      post.name ?? '', // Post title
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, left: 4, right: 4),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage('assets/images/bk2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(category), // Category name
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void startSearch(String p1) {
    context.read<SearchOnlineCubit>().getSearchResults(p1);
  }
}

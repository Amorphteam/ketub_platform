import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/search_model.dart';
import '../../../utils/epub_helper.dart';
import '../cubit/epub_cubit.dart';

class InternalSearchScreen extends StatefulWidget {
  final EpubCubit epubCubit;

  const InternalSearchScreen({Key? key, required this.epubCubit}) : super(key: key);

  @override
  State<InternalSearchScreen> createState() => _InternalSearchScreenState();
}

class _InternalSearchScreenState extends State<InternalSearchScreen> {
  String searchWord = ''; // Store the user's search input
  List<SearchModel> searchResults = [];
  final bookNameSearchingController = StreamController<String>();

  bool shouldStartSearch() {
    return searchWord.length > 3;
  }

  @override
  void dispose() {
    bookNameSearchingController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                searchWord = value;
                print("searchWord$value");
              });
              _handleSearch(searchWord, bookNameSearchingController); // Call handleSearch when the search word changes
            },
            decoration: InputDecoration(
              hintText: 'Enter search keyword',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          Expanded(
            child: buildSearchResultsList(searchResults),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResultsList(List<SearchModel> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return GestureDetector(
          onTap: () {
            openEpub(context: context, search: result);
          },
          child: ListTile(
            title: Text(result.bookTitle!),
            subtitle: Text(result.spanna!),
            // You can customize the display of search results as needed
          ),
        );
      },
    );
  }


_handleSearch(String sw, StreamController<String> bookNameSearching){
    if (shouldStartSearch()) {
      // Start the search only if the search word is longer than 3 letters
      final stream = widget.epubCubit.searchSingleBook(sw, bookNameSearching);
      setState(() {
        searchResults = []; // Clear previous search results
      });

      stream.listen((List<SearchModel> results) {
        setState(() {
          searchResults = results;
          // Update the search results
        });
      });

    }

}

}



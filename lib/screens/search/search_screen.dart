import 'package:flutter/material.dart';
import 'dart:async';

import '../../models/search_model.dart';
import '../../utils/search_helper.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchHelper = SearchHelper();
  final bookNameSearchingController = StreamController<String>();
  String searchWord = ''; // Store the user's search input
  List<SearchModel> searchResults = [];

  @override
  void dispose() {
    bookNameSearchingController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool shouldStartSearch() {
    return searchWord.length > 3;
  }

  void handleSearch() {
    if (shouldStartSearch()) {
      // Start the search only if the search word is longer than 3 letters
      final stream = searchHelper.searchAllBooks(
        allBooks, // Your list of book file paths
        searchWord,
        bookNameSearchingController,
      );


      setState(() {
        searchResults = []; // Clear previous search results
      });

      stream.listen((List<SearchModel> results) {
        setState(() {
          searchResults = results; // Update the search results
        });
      });
    }
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
              });
              handleSearch(); // Call handleSearch when the search word changes
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
            print('result is ${result.pageId}');
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
  // Define your list of book file paths
  List<String> allBooks = [
    '57.epub',
    '58.epub',
    '47.epub',
    // Add more book file paths as needed
  ];
}

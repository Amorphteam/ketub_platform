import 'package:flutter/cupertino.dart';

class SearchModel {
  final String? bookAddress;
  final String? bookTitle;
  final String? pageId;
  final String? spanna;
  final int searchCount;

  SearchModel({
    required this.bookAddress,
    required this.bookTitle,
    required this.pageId,
    required this.spanna,
    required this.searchCount,
  });
}


class SearchHighlight {
  final String searchHighlight;
  final SearchIndex index;

  SearchHighlight(this.searchHighlight, this.index);
}

class SearchIndex {
   int startIndex;
   int lastIndex;

  SearchIndex(this.startIndex, this.lastIndex);
}

class MySearcher {
  SearchIndex? searchInString(String? pageString, String sw, int i) {
    // Implement your search logic here
    // Replace this with actual search logic
    return null;
  }
}



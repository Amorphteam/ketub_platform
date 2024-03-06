import 'dart:async';
import 'package:epub_parser/epub_parser.dart';
import 'package:html/dom.dart' as dom;
import '../models/search_model.dart';
import 'epub_helper.dart';
import 'package:html/parser.dart' show parse;

class SearchHelper {
  final int searchSurroundCharNum = 60;
  bool _isSearchStopped = false;

  Future<void> searchAllBooks(
      List<String> allBooks, String word, Function(List<SearchModel>) onResultsFound) async {
    final List<SearchModel> allResults = [];
    for (final book in allBooks) {
      if (_isSearchStopped) break;
      final result = await _searchSingleBook(book, word);
      allResults.addAll(result);
      onResultsFound(allResults);
    }
  }

  Future<List<SearchModel>> _searchSingleBook(String bookPath, String sw) async {
    List<SearchModel> tempResult = [];

    try {
      final epubBook = await loadEpubFromAsset(bookPath);
      final spine = await extractHtmlContentWithEmbeddedImages(epubBook);
      var spineHtmlContent = spine.map((info) => info.modifiedHtmlContent).toList();
      var spineHtmlFileName = spine.map((info) => info.fileName).toList();

      for (int i = 0; i < spineHtmlContent.length; i++) {
        var page = _removeHtmlTags(spineHtmlContent[i]);
        var searchIndex = _searchInString(page, sw, 0);
        while (searchIndex.startIndex >= 0) {
          tempResult.add(SearchModel(
            bookAddress: bookPath,
            bookTitle: epubBook.Title,
            pageId: spineHtmlFileName[i],
            searchCount: tempResult.length + 1, // Updated to directly use the length of tempResult for search count
            spanna: _getHighlightedSection(searchIndex, page),
          ));

          searchIndex = _searchInString(page, sw, searchIndex.lastIndex + 1);
        }
      }
    } catch (e) {
      print('error in parsing epub: ${e.toString()}');
    }

    return tempResult;
  }

  String _getHighlightedSection(SearchIndex index, String wholeString) {
    final sw = wholeString.substring(index.startIndex, index.lastIndex);
    final swLength = index.lastIndex - index.startIndex;
    final lastIndex = wholeString.length;
    final firstCutIndex = index.startIndex - searchSurroundCharNum > 0 ? index.startIndex - searchSurroundCharNum : 0;
    final lastCutIndex = index.lastIndex + searchSurroundCharNum > lastIndex ? lastIndex : index.lastIndex + searchSurroundCharNum;
    final surr1 = "...${wholeString.substring(firstCutIndex, index.startIndex)}";
    final surr2 = "${wholeString.substring(index.lastIndex, lastCutIndex)}...";
    return "$surr1<mark>$sw</mark>$surr2";
  }

  SearchIndex _searchInString(String pageString, String sw, int start) {
    final startIndex = pageString.indexOf(sw, start);
    return startIndex >= 0 ? SearchIndex(startIndex, startIndex + sw.length) : SearchIndex(-1, -1);
  }

  Future<void> stopSearch(bool stop) async {
    _isSearchStopped = stop;
  }

  String _removeHtmlTags(String htmlString) {
    return parse(htmlString).documentElement!.text;
  }
}

class SearchIndex {
  final int startIndex;
  final int lastIndex;

  SearchIndex(this.startIndex, this.lastIndex);
}

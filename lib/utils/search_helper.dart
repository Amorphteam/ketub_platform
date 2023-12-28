import 'dart:async';

import 'package:epub_parser/epub_parser.dart';
import 'package:html/dom.dart' as dom;
import '../models/search_model.dart';
import 'epub_helper.dart';
import 'package:html/parser.dart' show parse;


class SearchHelper {
  int mSearchCount = 0;
  bool flag = false;
  int SEARCH_SURROUND_CHAR_NUM = 60;

  MySearcher? searcher;


  Stream<List<SearchModel>> searchAllBooks(
      List<String> allBooks, String word, StreamController<String> bookNameSearching) async* {
    final List<SearchModel> allResults = [];
    for (final book in allBooks) {
      if (flag) {
        break;
      }
      final result = await searchSingleBook(book, word, bookNameSearching);
      allResults.addAll(result);
      yield allResults;
    }
  }
  Future<List<SearchModel>> searchSingleBook(String bookPath, String sw, StreamController<String> bookNameSearching) async {
    List<SearchModel> tempResult = [];
    final assetPath = 'assets/epubs/$bookPath';

    EpubBook? epubBook;
    try {
      epubBook = await loadEpubFromAsset(assetPath);
    } catch (e) {
      print('error in parse epub: ${e.toString()}');
    }

    if (epubBook == null) {
      return List<SearchModel>.empty();
    }

    final spine = await extractHtmlContentWithEmbeddedImages(epubBook);
    var spineHtmlContent = spine.map((info) => info.modifiedHtmlContent).toList();
    var spineHtmlFileName = spine.map((info) => info.fileName).toList();

    for (int i = 0; i < spineHtmlContent.length; i++) {
      var page = removeHtmlTags(spineHtmlContent[i]);
      var searchCount = 0;
      var searchIndex = searchInString(page, sw, 0);
      while (searchIndex.startIndex >= 0) {
        tempResult.add(
          SearchModel(
            bookAddress: bookPath,
            bookTitle: epubBook.Title,
            pageId: spineHtmlFileName[i],
            searchCount: searchCount,
            spanna: getHighlightedSection(searchIndex, page),
          ),
        );

        searchCount++;
        searchIndex = searchInString(page, sw, searchIndex.lastIndex + 1);
      }
    }
    return tempResult;
  }


  String getHighlightedSection(SearchIndex index, String wholeString) {
    final sw = wholeString.substring(index.startIndex, index.lastIndex);
    final swLength = index.lastIndex - index.startIndex;
    final lastIndex = wholeString.length;
    final firstCutIndex =
    index.startIndex - SEARCH_SURROUND_CHAR_NUM > 0 ? index.startIndex - SEARCH_SURROUND_CHAR_NUM : 0;
    final lastCutIndex =
    index.startIndex + swLength + SEARCH_SURROUND_CHAR_NUM > lastIndex
        ? lastIndex
        : index.startIndex + swLength + SEARCH_SURROUND_CHAR_NUM;
    final surr1 = "...${wholeString.substring(firstCutIndex, index.startIndex)}";
    final surr2 = "${wholeString.substring(index.startIndex + swLength, lastCutIndex)}...";

    final section = "$surr1 $sw $surr2";

    return section;
  }


  SearchIndex searchInString(String? pageString, String sw, int i) {
    try {
      SearchIndex result = SearchIndex(-1, -1);
      int? startIndex = pageString?.indexOf(sw, i);

      if (startIndex != null && startIndex >= 0) {
        final lastIndex = startIndex + sw.length;
        result.startIndex = startIndex;
        result.lastIndex = lastIndex;
      }

      return result;
    } catch (e) {
      print('Error during search: $e');
      return SearchIndex(-1, -1);
    }
  }


  Future<void> stopSearch(bool flag) async {
    this.flag = flag;
  }

  Future<String> searchAndHighlight(String resource, String sw) async {
    if (sw.isEmpty || resource.isEmpty) {
      return "";
    }

    final doc = dom.Document.html(resource); // Use 'html' constructor to parse HTML
    final nodes = doc.body?.nodes ?? <dom.Node>[];

    mSearchCount = 0;

    for (var node in nodes) {
      if (node is dom.Text) {
        final text = node.text;
        final highlightedText = searchAndHighlightNode(text, sw);
        if (text != highlightedText) {
          final newNode = dom.Text(highlightedText);
          node.replaceWith(newNode);
        }
      }
    }

    return doc.outerHtml;
  }

  String searchAndHighlightNode(String mNode, String sw) {
    var node = mNode;
    try {
      var searchIndex = searcher?.searchInString(node, sw, 0);

      while (searchIndex!.startIndex >= 0) {
        final swReplacement =
        node.substring(searchIndex.startIndex, searchIndex.lastIndex);

        mSearchCount++;

        final searchHighlight =
        addHighlightClass(node, swReplacement, searchIndex, mSearchCount);
        node = searchHighlight.searchHighlight;
        searchIndex = searcher?.searchInString(node, sw, searchIndex.lastIndex + 1);
      }
      return " $node ";
    } catch (e) {
      print('Error during search: $e');
      return " $node ";
    }
  }


  SearchHighlight addHighlightClass(
      String resource, String sw, SearchIndex index, int searchCount) {
    final highlight = getHighlightClass(sw, searchCount);
    final nIndex = SearchIndex(index.startIndex, index.startIndex + highlight.length);

    return SearchHighlight(
      "${resource.substring(0, index.startIndex)}$highlight${resource.substring(index.lastIndex, resource.length)}",
      nIndex,
    );
  }


  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    final String plainText = parse(document.body!.text).documentElement!.text;
    return plainText;
  }

  String getHighlightClass(String sw, int searchCount) {
    return '<span class="search_highlight" id="search_$searchCount">$sw</span>';
  }
}
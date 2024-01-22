import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/search_model.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
import 'package:ketub_platform/utils/page_helper.dart';
import 'package:ketub_platform/utils/search_helper.dart';
import 'package:ketub_platform/utils/style_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/style_handler.dart';



part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {
  EpubCubit() : super(EpubInitState());
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   Future<void> loadToc() async {
//     emit(TocLoadingState());
//     try {
//       if (_epubBook != null) {
//         final List<EpubChapter> tocTreeList = _epubBook!.Chapters!;
//         _tocTreeList = tocTreeList;
//         emit(TocLoadedState(tocTreeList));
//       }
//     } catch (error) {
//       if (error is Exception) {
//         emit(ErrorState(error));
//       }
//     }
//   }
//
//   List<EpubChapter> filterToc({String? query}) {
//     if (_tocTreeList == null) {
//       return <EpubChapter>[];
//     }
//     if (query != null) {
//       final filteredList = _tocTreeList!.where((item) {
//         return item.Title?.toLowerCase().contains(query.toLowerCase()) ?? false;
//       }).toList();
//       return filteredList;
//     } else {
//       return _tocTreeList!;
//     }
//   }
//
//
//
//
//   Stream<List<SearchModel>> searchSingleBook(
//       String sw, StreamController<String> bookNameSearching) async* {
//     List<SearchModel> tempResult = [];
//     try {
//       if (_epubBook == null) {
//         yield List<SearchModel>.empty();
//       } else {
//         List<String> parts = _assetPath!.split('/'); // Split the string by '/'
//         String bookAddress = parts.last;
//         for (int i = 0; i < _spineHtmlContent!.length; i++) {
//           var page = searchHelper.removeHtmlTags(_spineHtmlContent![i]);
//           var searchCount = 0;
//           var searchIndex = searchHelper.searchInString(page, sw, 0);
//           while (searchIndex.startIndex >= 0) {
//             searchCount++;
//             tempResult.add(SearchModel(
//               bookAddress: bookAddress,
//               bookTitle: _epubBook!.Title,
//               pageId: _spineHtmlFileName![i],
//               searchCount: searchCount,
//               spanna: searchHelper.getHighlightedSection(searchIndex, page),
//             ));
//             searchIndex = searchHelper.searchInString(
//                 page, sw, searchIndex.lastIndex + 1);
//           }
//         }
//       }
//     } catch (error) {
//       if (error is Exception) {
//         print('error in search');
//       }
//     }
//
//     yield tempResult;
//   }
//
//   void openEpub(EpubChapter item) {
//     emit(TocItemTappedState(item));
//   }
//
//
//
//   Future<void> addBookmark(ReferenceModel bookmark) async {
//     try {
//       final referencesDatabase = ReferencesDatabase.instance;
//       // Check if the reference already exists in the database based on book title and page number
//       final existingReferences = await referencesDatabase
//           .getReferenceByBookTitleAndPage(bookmark.bookPath, bookmark.navIndex);
//       if (existingReferences.isEmpty) {
//         // The reference doesn't exist, so add it to the database
//         final int addStatus = await referencesDatabase.addReference(bookmark);
//         emit(BookmarkAddedState(addStatus));
//       } else {
//         // The reference already exists, handle this case (e.g., show an error message)
//         emit(EpubErrorState(error: 'Duplicate reference found'));
//       }
//     } catch (error) {
//       if (error is Exception) {
//         emit(EpubErrorState(error: error.toString()));
//       }
//     }
//   }



}

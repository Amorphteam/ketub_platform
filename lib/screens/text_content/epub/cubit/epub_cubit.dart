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

  StyleHelper styleHelper = StyleHelper(); // Initialize StyleHelper
  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;

  EpubBook? _epubBook;
  List<String>? _spineHtmlContent;
  List<String>? _spineHtmlFileName;
  String? _assetPath;
  List<EpubChapter>? _tocTreeList;

  final searchHelper = SearchHelper();



  Future<void> loadAndParseEpub(
      String assetPath, String? specificFileName) async {
    emit(EpubLoadingState());
    try {
      final EpubBook epubBook = await loadEpubFromAsset(assetPath);
      final List<HtmlFileInfo> epubContent =
      await extractHtmlContentWithEmbeddedImages(epubBook);

      _storeEpubDetails(epubBook, epubContent, assetPath);

      if (specificFileName != null) {
        final int pageIndex =
        await findPageIndexInEpub(epubBook, specificFileName);
        emit(EpubContentLoadedState(
            content: _spineHtmlContent!, pageIndex: pageIndex));
      } else {
        emit(EpubContentLoadedState(content: _spineHtmlContent!));
      }

      emit(EpubTitleLoadedState(bookTitle: epubBook.Title!));
      _loadUserPreferences();
      _emitLastPageSeen();
    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error: error.toString()));
      }
    }
  }

  void _storeEpubDetails(
      EpubBook epubBook, List<HtmlFileInfo> epubContent, String assetPath) {
    _epubBook = epubBook;
    _spineHtmlContent =
        epubContent.map((info) => info.modifiedHtmlContent).toList();
    _spineHtmlFileName = epubContent.map((info) => info.fileName).toList();
    _assetPath = assetPath;
  }

  Future<double?> getLastPageNumberForBook() async {
    final pageHelper = PageHelper();
    final parts = _assetPath!.split('/'); // Split the string by '/'
    final bookAddress = parts.last;
    final lastPageNumber =
    await pageHelper.getLastPageNumberForBook(bookAddress);
    return lastPageNumber;
  }

  Future<void> _emitLastPageSeen() async {
    final lastPageNumber = await getLastPageNumberForBook();
    if (lastPageNumber != null) {
      emit(LastPageSeenChangedState(page: lastPageNumber));
    }
  }


  //TODO: REFACTOR AND RENAME
  void changeFontSize(FontSizeCustom fontSize) {
    styleHelper.changeFontSize(fontSize);
    emit(FontSizeChangedState(fontSize: fontSize));
    _saveStyleHelperToPreferences(); // Save StyleHelper when it changes
  }

  void changeLineSpace(LineSpace lineSpace) {
    styleHelper.changeLineSpace(lineSpace);
    emit(LineSpaceChangedState(lineSpace: lineSpace));
    _saveStyleHelperToPreferences(); // Save StyleHelper when it changes
  }

  void changeFontFamily(FontFamily fontFamily) {
    styleHelper.changeFontFamily(fontFamily);
    emit(FontFamilyChangedState(fontFamily: fontFamily));
    _saveStyleHelperToPreferences(); // Save StyleHelper when it changes
  }

  Future<void> loadToc() async {
    emit(TocLoadingState());
    try {
      if (_epubBook != null) {
        final List<EpubChapter> tocTreeList = _epubBook!.Chapters!;
        _tocTreeList = tocTreeList;
        emit(TocLoadedState(tocTreeList));
      }
    } catch (error) {
      if (error is Exception) {
        emit(ErrorState(error));
      }
    }
  }

  List<EpubChapter> filterToc({String? query}) {
    if (_tocTreeList == null) {
      return <EpubChapter>[];
    }
    if (query != null) {
      final filteredList = _tocTreeList!.where((item) {
        return item.Title?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
      return filteredList;
    } else {
      return _tocTreeList!;
    }
  }

  Future<void> jumpToPage(String? chapterFileName) async {
    try {
      if (chapterFileName != null) {
        final int spineNumber =
            await findPageIndexInEpub(_epubBook!, chapterFileName);
        emit(EpubPageLoadedState(spineNumber: spineNumber));
      }
    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error: error.toString()));
      }
    }
  }


  Stream<List<SearchModel>> searchSingleBook(
      String sw, StreamController<String> bookNameSearching) async* {
    List<SearchModel> tempResult = [];
    try {
      if (_epubBook == null) {
        yield List<SearchModel>.empty();
      } else {
        List<String> parts = _assetPath!.split('/'); // Split the string by '/'
        String bookAddress = parts.last;
        for (int i = 0; i < _spineHtmlContent!.length; i++) {
          var page = searchHelper.removeHtmlTags(_spineHtmlContent![i]);
          var searchCount = 0;
          var searchIndex = searchHelper.searchInString(page, sw, 0);
          while (searchIndex.startIndex >= 0) {
            searchCount++;
            tempResult.add(SearchModel(
              bookAddress: bookAddress,
              bookTitle: _epubBook!.Title,
              pageId: _spineHtmlFileName![i],
              searchCount: searchCount,
              spanna: searchHelper.getHighlightedSection(searchIndex, page),
            ));
            searchIndex = searchHelper.searchInString(
                page, sw, searchIndex.lastIndex + 1);
          }
        }
      }
    } catch (error) {
      if (error is Exception) {
        print('error in search');
      }
    }

    yield tempResult;
  }

  void openEpub(EpubChapter item) {
    emit(TocItemTappedState(item));
  }

  // Save StyleHelper to SharedPreferences
  void _saveStyleHelperToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final styleJson = styleHelper.toJson();
    prefs.setString('styleHelper', jsonEncode(styleJson));
  }

  // Load StyleHelper from SharedPreferences
  void _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final styleJson = prefs.getString('styleHelper');
    if (styleJson != null) {
      final decodedStyle = jsonDecode(styleJson);
      final loadedStyleHelper = StyleHelper.fromJson(decodedStyle);
      styleHelper = loadedStyleHelper;
      emit(FontSizeChangedState(fontSize: styleHelper.fontSize));
      emit(LineSpaceChangedState(lineSpace: styleHelper.lineSpace));
      emit(FontFamilyChangedState(fontFamily: styleHelper.fontFamily));
    }
  }

  Future<void> addBookmark(ReferenceModel bookmark) async {
    try {
      final referencesDatabase = ReferencesDatabase.instance;
      // Check if the reference already exists in the database based on book title and page number
      final existingReferences = await referencesDatabase
          .getReferenceByBookTitleAndPage(bookmark.bookPath, bookmark.navIndex);
      if (existingReferences.isEmpty) {
        // The reference doesn't exist, so add it to the database
        final int addStatus = await referencesDatabase.addReference(bookmark);
        emit(BookmarkAddedState(addStatus));
      } else {
        // The reference already exists, handle this case (e.g., show an error message)
        emit(EpubErrorState(error: 'Duplicate reference found'));
      }
    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error: error.toString()));
      }
    }
  }

  void changePage(int newPage) {
    emit(PageChangedState(newPage));
  }

  Future<void> loadModifiedContent(String content) async {
    emit(EpubLoadingState());
    try {
      final String contentWithStyle = await injectCssJs(content);
      emit(EpubContentWithCssLoadedState(content: contentWithStyle));
    }catch(error){
      if (error is Exception){
        emit(EpubErrorState(error: error.toString()));
      }
    }
  }
}

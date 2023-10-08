import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:html/parser.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/reference_model.dart';
import '../../../models/search_model.dart';
import '../../../repositories/reference_database.dart';
import '../../../utils/search_helper.dart';
import '../../../utils/style_helper.dart';

part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {

  EpubCubit() : super(EpubInitState());

  StyleHelper styleHelper = StyleHelper(); // Initialize StyleHelper
  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;

  EpubBook? _epubBook;
  List<String>? _spine;
  String? _assetPath;
  List<EpubChapter>? _tocTreeList;

  final searchHelper = SearchHelper();


  void changeFontSize(FontSize fontSize) {
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


  Future<void>jumpToPage(String? chapterFileName) async {
    try {
      if (chapterFileName != null) {
        final int spineNumber = await getSpineNumber(_epubBook!, chapterFileName);
        emit(LoadedPageState(spineNumber: spineNumber));
      }
    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error.toString()));
      }
    }

  }


  Future<void> parseEpub(String assetPath, String? chapterFileName) async {
    emit(EpubLoadingState());
    try {
      final epubBook = await parseEpubFromAsset(assetPath);
      final spine = await getSpineFromEpub(epubBook);
      _epubBook = epubBook;
      _spine = spine;
      _assetPath = assetPath;

      if (chapterFileName != null) { // It's from TOC
        final int spineNumber = await getSpineNumber(epubBook, chapterFileName);
        emit(SpineLoadedState(spine: spine, spineNumber: spineNumber));
      } else {
        emit(SpineLoadedState(spine: spine));
      }
      emit(BookTitleLoadedState(epubBook.Title!));
      _loadStyleHelperFromPreferences(); // Load StyleHelper when parsing is done
    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error.toString()));
      }
    }
  }


  Stream<List<SearchModel>> searchSingleBook(String sw, StreamController<String> bookNameSearching) async* {
    List<SearchModel> tempResult = [];
    try{
      if (_epubBook == null) {
        yield List<SearchModel>.empty();
      }else{
        List<String> parts = _assetPath!.split('/'); // Split the string by '/'
        String bookAddress = parts.last;

        for (var page in _spine!){
          page = searchHelper.removeHtmlTags(page);
          var searchCount = 0;
          var searchIndex = searchHelper.searchInString(page, sw, 0);

          while (searchIndex.startIndex >= 0) {
            searchCount++;
            tempResult.add(SearchModel(bookAddress: bookAddress, bookTitle: _epubBook!.Title, pageId: '', searchCount: searchCount, spanna: searchHelper.getHighlightedSection(searchIndex, page),));

            searchIndex = searchHelper.searchInString(page, sw, searchIndex.lastIndex + 1);
          }
        }
      }
    }catch(error){
      if (error is Exception) {
        print('error in search');

      }
    }

    yield tempResult;
  }


  void openEpub(EpubChapter item){
    emit(TocItemTappedState(item));
  }

  // Save StyleHelper to SharedPreferences
  void _saveStyleHelperToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final styleJson = styleHelper.toJson();
    prefs.setString('styleHelper', jsonEncode(styleJson));
  }

  Future<void> addBookmark(ReferenceModel bookmark) async {
    try {
      final referencesDatabase = ReferencesDatabase.instance;
      // Check if the reference already exists in the database based on book title and page number
      final existingReferences = await referencesDatabase.getReferenceByBookTitleAndPage(
          bookmark.bookPath, bookmark.navIndex);
      if (existingReferences.isEmpty) {
        // The reference doesn't exist, so add it to the database
        final int addStatus = await referencesDatabase.addReference(bookmark);
        emit(BookmarkAddedState(addStatus));
      } else {
        // The reference already exists, handle this case (e.g., show an error message)
        emit(EpubErrorState('Duplicate reference found'));
      }
    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error.toString()));
      }
    }
  }

  // Load StyleHelper from SharedPreferences
  void _loadStyleHelperFromPreferences() async {
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

  void changePage(int newPage) {
    emit(PageChangedState(newPage));
  }


}





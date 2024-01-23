import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/style_model.dart';
import '../../../repositories/reference_database.dart';
import '../../../utils/epub_helper.dart';
import '../../../utils/search_helper.dart';
import '../../../utils/style_helper.dart';

part 'epub_viewer_state.dart';
part 'epub_viewer_cubit.freezed.dart';

class EpubViewerCubit extends Cubit<EpubViewerState> {
  EpubViewerCubit() : super(const EpubViewerState.initial());
  EpubBook? _epubBook;
  List<String>? _spineHtmlContent;
  List<String>? _spineHtmlFileName;
  String? _assetPath;
  String? _bookTitle;
  List<EpubChapter>? _tocTreeList;
  StyleHelper styleHelper = StyleHelper();

  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;
  final searchHelper = SearchHelper();

Future<void> loadAndParseEpub(
    String assetPath) async {
  print('AJCACJ $assetPath');
  emit(const EpubViewerState.loading());
  try {
    final EpubBook epubBook = await loadEpubFromAsset(assetPath);
    final List<HtmlFileInfo> epubContent =
    await extractHtmlContentWithEmbeddedImages(epubBook);

    _storeEpubDetails(epubBook, epubContent, assetPath);
    emit(EpubViewerState.loaded(content: _spineHtmlContent!, epubTitle: _bookTitle ?? ''));
    _loadUserPreferences();
    _emitLastPageSeen();
  } catch (error) {
      emit(EpubViewerState.error(error: error.toString()));
  }
}

  Future<void> _emitLastPageSeen() async {
    final lastPageNumber = await getLastPageNumberForBook(assetPath: _assetPath!);
    if (lastPageNumber != null) {
      emit(EpubViewerState.pageChanged(pageNumber: lastPageNumber.toInt()));
    }
  }

  void _storeEpubDetails(
      EpubBook epubBook, List<HtmlFileInfo> epubContent, String assetPath) {
    _epubBook = epubBook;
    _spineHtmlContent =
        epubContent.map((info) => info.modifiedHtmlContent).toList();
    _spineHtmlFileName = epubContent.map((info) => info.fileName).toList();
    _assetPath = assetPath;
    _bookTitle = epubBook.Title;
  }

  void changeStyle({FontSizeCustom? fontSize, LineSpace? lineSpace, FontFamily? fontFamily}) {
    fontSize != null ? styleHelper.changeFontSize(fontSize) : null;
    lineSpace != null ? styleHelper.changeLineSpace(lineSpace) : null;
    fontFamily != null ? styleHelper.changeFontFamily(fontFamily) : null;

    emit(EpubViewerState.styleChanged(fontSize: fontSize, lineHeight: lineSpace, fontFamily: fontFamily));
    _saveStyleHelperToPreferences();
  }


  Future<void> jumpToPage({String? chapterFileName, int? newPage}) async {
    if (newPage != null) {
      emit(const EpubViewerState.pageChanged());
    }
    try {
      if (chapterFileName != null) {
        final int spineNumber =
        await findPageIndexInEpub(_epubBook!, chapterFileName);
        emit(EpubViewerState.pageChanged(pageNumber: spineNumber));
      }
    } catch (error) {
        emit(EpubViewerState.error(error: error.toString()));
    }
  }



  _saveStyleHelperToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final styleJson = styleHelper.toJson();
    prefs.setString('styleHelper', jsonEncode(styleJson));
  }
  void _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final styleJson = prefs.getString('styleHelper');
    if (styleJson != null) {
      final decodedStyle = jsonDecode(styleJson);
      final loadedStyleHelper = StyleHelper.fromJson(decodedStyle);
      styleHelper = loadedStyleHelper;
      emit(EpubViewerState.styleChanged(fontFamily: styleHelper.fontFamily, fontSize: styleHelper.fontSize, lineHeight: styleHelper.lineSpace));
    }
  }
}

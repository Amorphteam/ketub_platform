import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/reference_model.dart';
import '../../../models/tree_toc_model.dart';
import '../../../repositories/reference_database.dart';
import '../../../utils/style_helper.dart';

part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {
  EpubCubit() : super(EpubInitState());

  StyleHelper styleHelper = StyleHelper(); // Initialize StyleHelper
  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;

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

  Future<void> parseEpub(String assetPath, String? chapterFileName) async {
    emit(EpubLoadingState());
    try {
      final epubBook = await parseEpubFromAsset(assetPath);
      final spine = await getSpineFromEpub(epubBook);
      if (chapterFileName != null){ // Its from toc
        final int spineNumber = await getSpineNumber(epubBook, chapterFileName);
        emit(SpineLoadedState(spine: spine, spineNumber: spineNumber));
      }else {
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

}

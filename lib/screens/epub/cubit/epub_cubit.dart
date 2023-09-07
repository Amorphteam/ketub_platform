import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/style_helper.dart';

part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {
  EpubCubit() : super(EpubInitState());

  StyleHelper styleHelper = StyleHelper(); // Initialize StyleHelper

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

  Future<void> parseEpub(String assetPath) async {
    emit(EpubLoadingState());
    try {
      final epubBook = await parseEpubFromAsset(assetPath);
      final spine = await getSpineFromEpub(epubBook);
      emit(SpineEpubLoadedState(spine));
      emit(BookTitleLoadedState(epubBook.Title!));
      final toc = await getToc(epubBook);

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

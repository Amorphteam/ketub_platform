import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/services.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {
  EpubCubit() : super(EpubInitState());

  void changeFontSize(FontSize fontSize) {
    emit(FontSizeChangedState(fontSize: fontSize));
  }

  void changeLineSpace(LineSpace lineSpace){
    emit(LineSpaceChangedState(lineSpace: lineSpace));
  }

  void changeFontFamily(FontFamily fontFamily){
    emit(FontFamilyChangedState(fontFamily: fontFamily));
  }

  Future<void> parseEpub(String assetPath) async {
    emit(EpubLoadingState());
    try {
        final epubBook = await parseEpubFromAsset(assetPath);
        final spine = await getSpineFromEpub(epubBook);
        emit(BookTitleLoadedState(epubBook.Title));
        emit(SpineEpubLoadedState(spine));

    } catch (error) {
      if (error is Exception) {
        emit(EpubErrorState(error.toString()));
      }
    }
  }
}

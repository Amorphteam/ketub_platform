import 'package:bloc/bloc.dart';

import '../../../models/style_model.dart';

part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {
  EpubCubit() : super(FontSizeState(fontSize: FontSize.normalFontSize));

  void onChangeFontSize(FontSize fontSize) {
    emit(FontSizeState(fontSize: fontSize));
  }

  void onChangeLineSpace(LineSpace lineSpace){
    emit(LineSpaceState(lineSpace: lineSpace));
  }

  void onChangeFontFamily(FontFamily fontFamily){
    emit(FontFamilyState(fontFamily: fontFamily));
  }
}

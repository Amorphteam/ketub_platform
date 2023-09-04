import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/style_model.dart';
part 'epub_state.dart';

class EpubCubit extends Cubit<EpubState> {
  EpubCubit() : super(FontSizeChangedState(fontSize: FontSize.normalFontSize));

  void changeFontSize(FontSize fontSize) {
    emit(FontSizeChangedState(fontSize: fontSize));
  }

  void changeLineSpace(LineSpace lineSpace){
    emit(LineSpaceChangedState(lineSpace: lineSpace));
  }

  void changeFontFamily(FontFamily fontFamily){
    emit(FontFamilyChangedState(fontFamily: fontFamily));
  }
}

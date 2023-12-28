import 'package:bloc/bloc.dart';
import 'package:epub_parser/epub_parser.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/utils/style_handler.dart';

import '../../../utils/epub_helper.dart';

part 'toc_state.dart';

class TocCubit extends Cubit<TocState> {
  TocCubit() : super(TocInitialState());

  Future<void> loadToc({String? query, String? bookPath}) async {
    emit(TocLoadingState());
    try {
      final assetPath = 'assets/epubs/$bookPath';
      final epubBook = await loadEpubFromAsset(assetPath);

      final List<EpubChapter> tocTreeList = epubBook.Chapters!;
      final List<EpubChapter> filteredList = tocTreeList.where((item) {
        return item.Title!.toLowerCase().contains(query!.toLowerCase());
      }).toList();
      emit(TocLoadedState(filteredList));
    } catch (error) {
      if (error is Exception) {
        emit(TocErrorState(error));
      }
    }
  }

  void openEpub(EpubChapter item){
    emit(TocItemTappedState(item));
  }
}

import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/utils/temp_data.dart';

part 'toc_state.dart';

class TocCubit extends Cubit<TocState> {
  TocCubit() : super(TocInitialState());

  Future<void> loadToc({String query = ''}) async {
    emit(TocLoadingState());
    try {
      final List<TreeTocModel> tocTreeList = tempToc;
      final List<TreeTocModel> filteredList = tocTreeList.where((item) {
        return item.bookTitle.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(TocLoadedState(filteredList));
    } catch (error) {
      if (error is Exception) {
        emit(TocErrorState(error));
      }
    }
  }

  void openEpub(TreeTocModel item){
    emit(TocItemTappedState(item));
  }
}

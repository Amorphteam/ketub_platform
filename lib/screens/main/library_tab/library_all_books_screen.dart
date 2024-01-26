import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/main/library_tab/widgets/book_list_widget.dart';
import 'package:ketub_platform/screens/search/search_screen.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
import 'cubit/library_cubit.dart';

class LibraryAllBooksScreen extends StatefulWidget {
  const LibraryAllBooksScreen();

  @override
  State<LibraryAllBooksScreen> createState() => _LibraryAllBooksScreenState();
}

class _LibraryAllBooksScreenState extends State<LibraryAllBooksScreen> {

   List<CategoryModel> cats = [];

  @override
  void initState() {
    super.initState();
    _loadAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<LibraryCubit, LibraryState>(
          listener: (context, state) {
             if (state is LibraryErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            } else if (state is BookClickedState){
               if (state.cats.length == 1){
                 openEpub(context: context, cat: state.cats.first);

               }

               else {

               }
            }
          },
          builder: (context, state) {
            if (state is AllBooksLoadedState ) {
              cats = state.cats;

              return Flexible(
                  child:
                BookListWidget(bookList: state.books),
              );
            } else if (state is LibraryLoadingState) {
              return const CircularProgressIndicator();
            } else {
              return const SizedBox.shrink();
            }
          },
          buildWhen: (previousState, state) {
            return state is AllBooksLoadedState || state is LibraryLoadingState;
          },
        )
      ],
    );
  }

  void _loadAllBooks() {
    BlocProvider.of<LibraryCubit>(context).loadAllBooks();
  }


}

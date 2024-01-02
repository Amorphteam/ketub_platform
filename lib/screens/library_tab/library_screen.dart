import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/library_tab/widgets/book_list_widget.dart';
import 'package:ketub_platform/screens/search/search_screen.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
import '../../models/book_model.dart';
import '../../repositories/articles_online_repository.dart';
import '../../utils/web_view_helper.dart';
import 'cubit/library_cubit.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen();

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(allCats: cats),
                ),
              );
            },
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
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
              return CircularProgressIndicator();
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

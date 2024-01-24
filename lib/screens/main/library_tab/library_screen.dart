import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/main/library_tab/widgets/book_list_widget.dart';
import 'package:ketub_platform/screens/search/search_screen.dart';
import 'package:ketub_platform/utils/epub_helper.dart';
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
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200], // Adjust the color to match your UI design
                hintText: 'أدخل كلمة لبدء البحث', hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]), // Your hint text in Arabic
                prefixIcon: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: Colors.grey[600], // Adjust the color as needed
                    width: 20, // Adjust the size as needed
                    height: 20, // Adjust the size as needed
                  ),
                  onPressed: () {
                    // Add the search logic here if necessary
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic, color: Colors.grey), // Use your SVG asset if needed
                  onPressed: () {
                    // Implement your voice search logic
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none, // No border
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20), // Adjust padding
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

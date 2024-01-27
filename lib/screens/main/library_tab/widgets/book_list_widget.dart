import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';
import 'package:ketub_platform/screens/epub_viewer/epub_viewer_screen.dart';
import '../cubit/library_cubit.dart';

class BookListWidget extends StatefulWidget {
  final List<BookModel> bookList;

  const BookListWidget({Key? key, required this.bookList}) : super(key: key);

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10, // Spacing between columns
        mainAxisSpacing: 10, // Spacing between rows
        childAspectRatio: 0.6,
      ),
      itemCount: widget.bookList.length,
      itemBuilder: (context, index) {
        BookModel bookItem = widget.bookList[index];
        return GestureDetector(
          onTap: () => _handleOnTap(context, bookItem),
          onDoubleTap: _handleDoubleTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 150,
                      // Set the width to one third of the screen width minus the horizontal padding
                      width: (MediaQuery.of(context).size.width - 24) / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/${bookItem.bookCover ?? 'book_sample.png'}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Text(
                  bookItem.bookName ?? 'Book Name',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleDoubleTap() async {
    //   try {
    //     final article = await ArticleOnlineRepository().getArticles(44621);
    //
    //     // Check if the widget is still in the widget tree
    //     if (!mounted) return;
    //
    //
    //     Navigator.push(
    //       context,
    //         MaterialPageRoute(
    //           // builder: (context) => CustomWebView(content: "<html><head></head><body> ${article.description} </body></html>")));
    //   } catch (error) {
    //     // Handle error
    //     if (!mounted) return;
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(error.toString()))
    //     );
    //   }
    // }
  }

  _handleOnTap(BuildContext context, BookModel bookItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(bookItem.bookName ?? 'Book Name'),
          ),
          content: SizedBox(
            width: double.maxFinite,
            // Adjust the height as needed to fit two rows of books
            height: MediaQuery.of(context).size.height * 0.24,

            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Two books per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
              ),
              itemCount: 5, // assuming there are at least 5 books in the list
              itemBuilder: (BuildContext context, int index) {
                BookModel book = widget.bookList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openEpub(widget.bookList[index].id ?? 1);
                      },
                      child: Container(
                        height: 150,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/${bookItem.bookCover ?? 'book_sample.png'}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Expanded(child: Text('الجزء $index')),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

   _openEpub(int id) {
     BlocProvider.of<LibraryCubit>(context).openEpub(id);
   }
}

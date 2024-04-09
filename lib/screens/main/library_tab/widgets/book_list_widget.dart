import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';
import 'package:ketub_platform/screens/epub_viewer/epub_viewer_screen.dart';
import '../../../../utils/common.dart';
import '../cubit/library_all_books_cubit.dart';

class BookListWidget extends StatefulWidget {
  final List<BookModel> bookList;
  final LibraryAllBooksCubit cubit;
  final String logo;
  final String title;
  const BookListWidget({Key? key, required this.bookList, required this.cubit, required this.logo, required this.title}) : super(key: key);

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildLogoAndTitle(context, widget.logo, widget.title, ''),
        SizedBox(
          height: 260, // Set the height to accommodate the book image and title text
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Set the direction to horizontal
            itemCount: widget.bookList.length,
            itemBuilder: (context, index) {
              BookModel bookItem = widget.bookList[index];
              return GestureDetector(
                onTap: () => _handleOnTap(context, bookItem),
                child: Container(
                  width: 120, // Fixed width for each book item
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Space around items
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180, // Height of the book cover image
                        width: 120, // Width of the book cover image
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
                      SizedBox(height: 10), // Space between the book cover and title
                      Text(
                        bookItem.bookName ?? 'Book Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                        maxLines: 2, // Ensure text does not exceed more than 2 lines
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16.0),
            alignment: Alignment.bottomLeft, child: Text('مشاهدة الجميع')),
      ],
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
    _openEpub(bookItem.id?? 1, bookItem.bookName?? ' ');
  }

   _openEpub(int id, String bookName) {
     widget.cubit.openEpub(id, bookName);
   }
}

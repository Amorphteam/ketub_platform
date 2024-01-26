import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
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
          onTap: () {
            BlocProvider.of<LibraryCubit>(context).openEpub(
                widget.bookList[index].id!);
          },
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
}
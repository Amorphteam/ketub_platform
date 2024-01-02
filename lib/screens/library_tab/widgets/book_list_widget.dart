import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/library_tab/cubit/library_cubit.dart';

import '../../../repositories/articles_online_repository.dart';
import '../../../utils/epub_helper.dart';
import '../../../utils/web_view_helper.dart';

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
        childAspectRatio: 0.9,
      ),
      itemCount: widget.bookList.length,
      itemBuilder: (context, index) {
        BookModel bookItem = widget.bookList[index];
        return GestureDetector(
          onTap: () {
            BlocProvider.of<LibraryCubit>(context).openEpub(widget.bookList[index].id!);

          },
          onDoubleTap: _handleDoubleTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/${bookItem.bookCover ?? 'book_sample.png'}',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                bookItem.bookName ?? 'sample',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );

  }

  Future<void> _handleDoubleTap() async {
    try {
      final article = await ArticleOnlineRepository().getArticles(44621);

      // Check if the widget is still in the widget tree
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewHelper(content: article.description!),
        ),
      );
    } catch (error) {
      // Handle error
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString()))
      );
    }
  }

}

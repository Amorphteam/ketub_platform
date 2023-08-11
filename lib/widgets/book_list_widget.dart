import 'package:flutter/material.dart';
import 'package:ketub_platform/Screens/detail_book_screen.dart';
import 'package:ketub_platform/models/book_model.dart';

class BookListWidget extends StatelessWidget {
  final List<BookModel> bookList;

  const BookListWidget({Key? key, required this.bookList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10, // Spacing between columns
        mainAxisSpacing: 10, // Spacing between rows
        childAspectRatio: 0.9,
      ),
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        BookModel item = bookList[index];

        return GestureDetector(
          onTap: () {
            _navigateToDetailScreen(context, item);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/${item.bookCover ?? 'book_sample.png'}',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.bookName ?? 'sample',
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

  void _navigateToDetailScreen(BuildContext context, BookModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBookScreen(bookModel: item),
      ),
    );
  }
}

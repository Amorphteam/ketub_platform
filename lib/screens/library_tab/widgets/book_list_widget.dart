import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/library_tab/cubit/library_cubit.dart';

import '../../../utils/epub_helper.dart';

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
        BookModel bookItem = bookList[index];
        return GestureDetector(
          onTap: () {
            BlocProvider.of<LibraryCubit>(context).openEpub(bookList[index].id!);
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


}

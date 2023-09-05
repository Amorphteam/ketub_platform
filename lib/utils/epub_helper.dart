import 'dart:typed_data';

import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';

import '../models/book_model.dart';
import '../screens/epub/cubit/epub_cubit.dart';
import '../screens/epub/epub_screen.dart';

//TODO: Change it
void openEpub(BuildContext context, BookModel? book, ReferenceModel? reference, TreeTocModel? toc) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          BlocProvider(
            create: (context) => EpubCubit(),
            child: EpubScreen(bookModel: book, referenceModel: reference, tocModel: toc,),
          ),
    ),
  );
}


Future<List<String>> parseEpubFromAsset(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  List<int> bytes = data.buffer.asUint8List();

  EpubBook epubBook = await EpubReader.readBook(Uint8List.fromList(bytes));
  EpubContent? bookContent = epubBook.Content;

  // All XHTML files in the book (file name is the key)
  Map<String, EpubTextContentFile>? htmlFiles = bookContent?.Html;
  List<String> spine = [];
  for (var htmlFile in htmlFiles!.values) {
    String? htmlContent = htmlFile.Content;
    spine.add(htmlContent!);
  }

  return spine;
}
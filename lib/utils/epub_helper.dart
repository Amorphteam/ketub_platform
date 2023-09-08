import 'dart:convert';
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


Future<List<String>> getSpineFromEpub(EpubBook epubBook) async {
  EpubContent? bookContent = epubBook.Content;
  Map<String, EpubByteContentFile>? images = bookContent?.Images;
  Map<String, EpubTextContentFile>? htmlFiles = bookContent?.Html;
  List<String> spine = [];
  for (var htmlFile in htmlFiles!.values) {
    String? htmlContent = htmlFile.Content;
    if (htmlContent!.contains('<img ')) {
      getImageName(htmlContent);
      final imageByte = images?['Images/${getImageName(htmlContent)}']?.Content;
      final base64Image = base64Encode(imageByte!);
      htmlContent = htmlContent.replaceAll(RegExp(r'<img[^>]*>'),
          "<img src=\"data:image/jpg;base64,$base64Image\" alt=\"My Image\" />");
    }
    spine.add(htmlContent!);
  }

  return spine;
}

String getImageName(String htmlContent) {
  // Define a regular expression to extract the image filename
  final RegExp imgSrcRegex = RegExp(r'src="([^"]+)"');

  // Find the first match of the regular expression in the HTML content
  final Match? match = imgSrcRegex.firstMatch(htmlContent);

  // Extract the image filename if a match is found
  String imageName = '';
  if (match != null && match.groupCount >= 1) {
    imageName = match.group(1)!;
    // Split the path and get the filename
    final List<String> pathSegments = imageName.split('/');
    if (pathSegments.isNotEmpty) {
      imageName = pathSegments.last;
    }
  }
  return imageName;
}

Future<EpubBook> parseEpubFromAsset(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  List<int> bytes = data.buffer.asUint8List();

  EpubBook epubBook = await EpubReader.readBook(Uint8List.fromList(bytes));

  return epubBook;
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/html_viewer/cubit/html_viewer_cubit.dart';
import 'package:ketub_platform/screens/html_viewer/html_viewer_screen.dart';


import '../models/book_model.dart';
import '../models/search_model.dart';


void openEpub({
  required BuildContext context,
  CategoryModel? cat,
  ReferenceModel? reference,
  EpubChaptersWithBookPath? toc,
  SearchModel? search
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          BlocProvider(
            create: (context) => HtmlViewerCubit(),
            child: const HtmlViewerScreen(),
          ),
    ),
  );
}

Future<List<HtmlFileInfo>> extractHtmlContentWithEmbeddedImages(EpubBook epubBook) async {
  EpubContent? bookContent = epubBook.Content;
  Map<String, EpubByteContentFile>? images = bookContent?.Images;
  Map<String, EpubTextContentFile>? htmlFiles = bookContent?.Html;

  List<HtmlFileInfo> htmlContentList = [];
  for (var htmlFile in htmlFiles!.values) {
    String htmlContent = embedImagesInHtmlContent(htmlFile, images);
    htmlContentList.add(HtmlFileInfo(htmlFile.FileName!, htmlContent));
  }

  return htmlContentList;
}

String embedImagesInHtmlContent(EpubTextContentFile htmlFile, Map<String, EpubByteContentFile>? images) {
  String htmlContent = htmlFile.Content!;
  final imgRegExp = RegExp(r'<img[^>]*>');
  Iterable<RegExpMatch> imgTags = imgRegExp.allMatches(htmlContent);

  for (var imgMatch in imgTags) {
    String imgTag = imgMatch.group(0)!;
    String imageName = extractImageNameFromTag(imgTag);
    String? base64Image = convertImageToBase64(images?['Images/$imageName']);

    if (base64Image != null) {
      String replacement = "<img src=\"data:image/jpg;base64,$base64Image\" alt=\"$imageName\" />";
      htmlContent = htmlContent.replaceFirst(imgTag, replacement);
    }
  }

  return htmlContent;
}

String? convertImageToBase64(EpubByteContentFile? imageFile) {
  if (imageFile == null) return null;
  return base64Encode(imageFile.Content!);
}


Future<int> findPageIndexInEpub(EpubBook epubBook, String fileName) async {
  EpubContent? bookContent = epubBook.Content;
  Map<String, EpubTextContentFile>? htmlFiles = bookContent?.Html;
  if (htmlFiles != null) {
    int index = 0;
    for (String key in htmlFiles.keys) {
      if (key == fileName) {
        // Found the chapterFileName in the map, so return its position (item number)
        return index;
      }
      index++;
    }
  }
  // If chapterFileName is not found in the map, return -1 or handle it as needed.
  return -1;
}



String extractImageNameFromTag(String imageTag) {
  // Define a regular expression to extract the image filename
  final RegExp imgSrcRegex = RegExp(r'src="([^"]+)"');

  // Find the first match of the regular expression in the HTML content
  final Match? match = imgSrcRegex.firstMatch(imageTag);

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

Future<EpubBook> loadEpubFromAsset(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  List<int> bytes = data.buffer.asUint8List();

  EpubBook epubBook = await EpubReader.readBook(Uint8List.fromList(bytes));

  return epubBook;
}

class HtmlFileInfo {
  final String fileName;
  final String modifiedHtmlContent;

  HtmlFileInfo(this.fileName, this.modifiedHtmlContent);
}
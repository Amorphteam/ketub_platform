import 'dart:convert';
import 'dart:typed_data';

import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';
import 'package:ketub_platform/utils/page_helper.dart';
import '../models/search_model.dart';
import '../screens/epub_viewer/epub_viewer_screen.dart';


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
            create: (context) => EpubViewerCubit(),
            child: EpubViewerScreen(catModel: cat,referenceModel: reference, searchModel: search, tocModel: toc),
          ),
    ),
  );
}

Future<List<HtmlFileInfo>> extractHtmlContentWithEmbeddedImages(EpubBook epubBook) async {
  EpubContent? bookContent = epubBook.Content;
  Map<String, EpubByteContentFile>? images = bookContent?.Images;
  Map<String, EpubTextContentFile>? htmlFiles = bookContent?.Html;

  List<HtmlFileInfo> htmlContentList = [];
  if (htmlFiles != null) {
    int index = 0; // Initialize a counter to keep track of the file index
    for (var entry in htmlFiles.entries) {
      String htmlContent = embedImagesInHtmlContent(entry.value, images);
      // Assuming HtmlFileInfo can take an additional `fileIndex` parameter
      htmlContentList.add(HtmlFileInfo(entry.key, htmlContent, index++));
    }
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

Future<double?> getLastPageNumberForBook({required String assetPath}) async {
  final pageHelper = PageHelper();
  final parts = assetPath.split('/'); // Split the string by '/'
  final bookAddress = parts.last;
  final lastPageNumber =
  await pageHelper.getLastPageNumberForBook(bookAddress);
  return lastPageNumber;
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
  final int pageIndex;

  HtmlFileInfo(this.fileName, this.modifiedHtmlContent, this.pageIndex);
}
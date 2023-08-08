import 'dart:ffi';

class ReferenceModel {
  final int id;
  final String title;
  final String bookName;
  final String? bookPath;
  final String? navIndex;
  final String? navUri;
  final double? scrollPercent;

  ReferenceModel(
      {required this.id,
      required this.title,
      required this.bookName,
      required this.bookPath,
      required this.navIndex,
      required this.navUri,
      required this.scrollPercent});
}

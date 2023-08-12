class ReferenceModel {
  int id;
  String title;
  String bookName;
  String bookPath;
  String navIndex;
  String navUri;
  double scrollPercent;

  ReferenceModel({
    required this.id,
    required this.title,
    required this.bookName,
    required this.bookPath,
    required this.navIndex,
    required this.navUri,
    required this.scrollPercent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'bookName': bookName,
      'bookPath': bookPath,
      'navIndex': navIndex,
      'navUri': navUri,
      'scrollPercent': scrollPercent,
    };
  }
}

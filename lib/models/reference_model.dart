class ReferenceModel {
  int? id;
  String title;
  String bookName;
  String bookPath;
  String navIndex;

  ReferenceModel({
    this.id,
    required this.title,
    required this.bookName,
    required this.bookPath,
    required this.navIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'bookName': bookName,
      'bookPath': bookPath,
      'navIndex': navIndex,
    };
  }
}
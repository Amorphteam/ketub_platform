class TocGroupItem {
  final int id;
  final String bookTitle;
  final String bookName;
  final List<TocFirstChildItem> childItems;

  TocGroupItem({
    required this.id,
    required this.bookTitle,
    required this.bookName,
    required this.childItems,
  });
}

class TocFirstChildItem {
  final int id;
  final String bookTitle;
  final String bookName;
  final List<TocSecondChildItem> childItems2;

  TocFirstChildItem({
    required this.id,
    required this.bookTitle,
    required this.bookName,
    required this.childItems2,
  });
}

class TocSecondChildItem {
  final int id;
  final String bookTitle;
  final String bookName;

  TocSecondChildItem({
    required this.id,
    required this.bookTitle,
    required this.bookName,
  });
}


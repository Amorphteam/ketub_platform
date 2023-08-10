class TocGroupItem {
  final int id;
  final String bookTitle;
  final String bookName;
  final List<TocGroupItem>? childItems;

  TocGroupItem({
    required this.id,
    required this.bookTitle,
    required this.bookName,
    required this.childItems,
  });
}

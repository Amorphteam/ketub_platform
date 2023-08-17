class TreeTocModel {
  final int id;
  final String bookTitle;
  final String bookName;
  final List<TreeTocModel>? childItems;

  TreeTocModel({
    required this.id,
    required this.bookTitle,
    required this.bookName,
    required this.childItems,
  });
}

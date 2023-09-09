class CategoryModel {
  final int? id;
  final int? catId;
  final String? bookPath;
  final String? bookName;
  final String? bookCover;
  final String? bookStyle;
  final String? bookAuthor;
  final String? description;

  CategoryModel({
    required this.id,
    required this.catId,
    required this.bookPath,
    required this.bookName,
    required this.bookCover,
    required this.bookStyle,
    required this.bookAuthor,
    required this.description,
  });
}

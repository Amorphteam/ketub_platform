import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/toc_model.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

List<CategoryModel> categoryItems = [
  CategoryModel(
      id: 1, catName: 'Item 1', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 2, catName: 'Item 2', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 3, catName: 'Item 3', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 4, catName: 'Item 4', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 5, catName: 'Item 5', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 6, catName: 'Item 6', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 7, catName: 'Item 7', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 8, catName: 'Item 8', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 9, catName: 'Item 9', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 10, catName: 'Item 10', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 11, catName: 'Item 11', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 12, catName: 'Item 12', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 13, catName: 'Item 13', catCover: 'book_sample.png', des: ''),
  CategoryModel(
      id: 14, catName: 'Item 14', catCover: 'book_sample.png', des: ''),
];

List<TocGroupItem> indexItems = [
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 7),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocFirstChildItem(
        id: 1,
        bookTitle: loremIpsum(words: 7),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3)),
        ],
      ),
      TocFirstChildItem(
        id: 2,
        bookTitle: loremIpsum(words: 7),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3)),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocFirstChildItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
      TocFirstChildItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocFirstChildItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
      TocFirstChildItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocFirstChildItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
      TocFirstChildItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocFirstChildItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
      TocFirstChildItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems2: [
          TocSecondChildItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
          TocSecondChildItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3)),
        ],
      ),
    ],
  ),
];

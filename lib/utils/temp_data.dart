import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/toc_model.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../models/reference_model.dart';

List<BookModel> tempBook = [
  BookModel(
      id: 1, bookName: 'Item 1', bookCover: 'book_sample.png', description: ''),
  BookModel(
      id: 2, bookName: 'Item 2', bookCover: 'book_sample.png', description: ''),
  BookModel(
      id: 3, bookName: 'Item 3', bookCover: 'book_sample.png', description: ''),
];

List<ReferenceModel> tempReferences = [
  ReferenceModel(
    id: 1,
    title: "Reference 1",
    bookName: "Book 1",
    bookPath: "path/to/book1.pdf",
    navIndex: "1",
    navUri: "nav1",
    scrollPercent: 0.5,
  ),
  ReferenceModel(
    id: 2,
    title: "Reference 2",
    bookName: "Book 2",
    bookPath: "path/to/book2.pdf",
    navIndex: "2",
    navUri: "nav2",
    scrollPercent: 0.8,
  ),
  ReferenceModel(
    id: 3,
    title: "Reference 3",
    bookName: "Book 3",
    bookPath: "path/to/book3.pdf",
    navIndex: "3",
    navUri: "nav3",
    scrollPercent: 0.2,
  ),
];

List<TocGroupItem> tempToc = [
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 7),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocGroupItem(
        id: 1,
        bookTitle: loremIpsum(words: 7),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
      TocGroupItem(
        id: 2,
        bookTitle: loremIpsum(words: 7),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 7), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocGroupItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
      TocGroupItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocGroupItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
      TocGroupItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocGroupItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
      TocGroupItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
    ],
  ),
  TocGroupItem(
    id: 1,
    bookTitle: loremIpsum(words: 10),
    bookName: loremIpsum(words: 3),
    childItems: [
      TocGroupItem(
        id: 1,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
      TocGroupItem(
        id: 2,
        bookTitle: loremIpsum(words: 10),
        bookName: loremIpsum(words: 3),
        childItems: [
          TocGroupItem(id: 1, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 2, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
          TocGroupItem(id: 3, bookTitle: loremIpsum(words: 10), bookName: loremIpsum(words: 3), childItems: null),
        ],
      ),
    ],
  ),
];

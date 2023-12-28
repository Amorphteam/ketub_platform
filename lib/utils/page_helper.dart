import 'package:shared_preferences/shared_preferences.dart';

class PageHelper {
  static const _key = 'bookData';

  // Save a book's data (book name as key, last page number as value).
  Future<void> saveBookData(String bookName, double lastPageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final bookData = prefs.getStringList(_key) ?? [];

    // Check if the book name already exists in the data list.
    int existingIndex = bookData.indexWhere((entry) {
      final parts = entry.split(':');
      return parts.isNotEmpty && parts[0] == bookName;
    });

    if (existingIndex != -1) {
      // If the book name already exists, update the value (last page number).
      bookData[existingIndex] = '$bookName:$lastPageNumber';
    } else {
      // If it's a new entry, add it to the list.
      bookData.add('$bookName:$lastPageNumber');
    }

    await prefs.setStringList(_key, bookData);
  }

  // Retrieve the last page number for a given book name.
  Future<double?> getLastPageNumberForBook(String bookName) async {
    final prefs = await SharedPreferences.getInstance();
    final bookData = prefs.getStringList(_key) ?? [];

    for (final entry in bookData) {
      final parts = entry.split(':');
      if (parts.length == 2 && parts[0] == bookName) {
        return double.tryParse(parts[1]);
      }
    }

    return null; // Book not found in storage.
  }
}

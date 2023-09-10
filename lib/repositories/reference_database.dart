import 'package:ketub_platform/models/reference_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class ReferencesDatabase {
  static final ReferencesDatabase instance = ReferencesDatabase._init();
  static Database? _database;

  ReferencesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('reference_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reference_database(
        id INTEGER PRIMARY KEY,
        title TEXT,
        bookName TEXT,
        bookPath TEXT,
        navIndex TEXT
      )
    ''');
  }

  Future<int> addReference(ReferenceModel referenceModel) async {
    final db = await instance.database;
    return await db.insert('reference_database', referenceModel.toMap());
  }

  Future<List<ReferenceModel>> getAllReferences() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('reference_database');
    return List.generate(maps.length, (i) {
      return ReferenceModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        bookName: maps[i]['bookName'],
        bookPath: maps[i]['bookPath'],
        navIndex: maps[i]['navIndex'],
      );
    });
  }

  Future<int> updateReference(ReferenceModel referenceModel) async {
    final db = await instance.database;
    return await db.update(
      'reference_database',
      referenceModel.toMap(),
      where: 'id = ?',
      whereArgs: [referenceModel.id],
    );
  }

  Future<List<ReferenceModel>> getReferenceByBookTitleAndPage(String bookPath, String pageNumber) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'reference_database',
      where: 'bookPath = ? AND navIndex = ?',
      whereArgs: [bookPath, pageNumber],
    );

    return List.generate(maps.length, (i) {
      return ReferenceModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        bookName: maps[i]['bookName'],
        bookPath: maps[i]['bookPath'],
        navIndex: maps[i]['navIndex'],
      );
    });
  }

  Future<List<ReferenceModel>> getFilterReference(String query) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('reference_database');

    List<ReferenceModel> filteredList = List.generate(maps.length, (i) {
      return ReferenceModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        bookName: maps[i]['bookName'],
        bookPath: maps[i]['bookPath'],
        navIndex: maps[i]['navIndex'],
      );
    });

    if (query.isNotEmpty) {
      filteredList = filteredList.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    return filteredList;
  }

  Future<int> deleteReference(int id) async {
    final db = await instance.database;
    return await db.delete(
      'reference_database',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

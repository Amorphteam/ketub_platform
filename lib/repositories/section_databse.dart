import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/section.dart';


class SectionDatabase {
  static final SectionDatabase instance = SectionDatabase._init();

  static Database? _database;

  SectionDatabase._init();

  Future<Database> initDb() async {
    if (_database != null) {
      return _database!;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sections_list.db');
    final file = File(path);

    if (file.existsSync()) {
      print('database already exists');
      _database = await openDatabase(path);
    } else {
      print('section database does not exist');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      final ByteData data =
      await rootBundle.load('assets/databases/sections_list.db');
      final bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await file.writeAsBytes(bytes, flush: true);
      print('section database copied');
      _database = await openDatabase(path);
    }

    return _database!;
  }

  Future<List<Section>> readRandomSections(int count) async {
    final db = await initDb();
    // Using ORDER BY RANDOM() and LIMIT to get random rows
    final result = await db.query(
      'sections_list',
      orderBy: 'RANDOM()',
      limit: count,
    );
    return result.map((row) => Section(
      id: row['_id'] as int?,
      title: row['title'] as String,
      bookPath: row['book_path'] as String,
      bookName: row['book_name'] as String,
      sectionIndex: row['section_index'] as int,
    )).toList();
  }



}

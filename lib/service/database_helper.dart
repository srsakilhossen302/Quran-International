import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quran.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    // Create Surahs table
    await db.execute('''
      CREATE TABLE surahs (
        id INTEGER PRIMARY KEY,
        enName TEXT,
        arName TEXT,
        type TEXT,
        verses INTEGER
      )
    ''');

    // Create Bookmarks table
    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surahName TEXT,
        verseInfo TEXT,
        arabicText TEXT,
        englishTranslation TEXT
      )
    ''');

    // Create Highlights table
    await db.execute('''
      CREATE TABLE highlights (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surahName TEXT,
        reference TEXT,
        date TEXT,
        text TEXT,
        colorValue INTEGER,
        colorName TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // If highlights table was created in version 1 without colorName, we recreate it
      await db.execute('DROP TABLE IF EXISTS highlights');
      await db.execute('''
        CREATE TABLE highlights (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          surahName TEXT,
          reference TEXT,
          date TEXT,
          text TEXT,
          colorValue INTEGER,
          colorName TEXT
        )
      ''');
    }
  }

  // SURAH OPERATIONS
  Future<int> insertSurah(Map<String, dynamic> surah) async {
    final db = await instance.database;
    return await db.insert('surahs', surah, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getSurahs() async {
    final db = await instance.database;
    return await db.query('surahs');
  }

  // BOOKMARK OPERATIONS
  Future<int> insertBookmark(Map<String, dynamic> bookmark) async {
    final db = await instance.database;
    return await db.insert('bookmarks', bookmark, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final db = await instance.database;
    return await db.query('bookmarks');
  }

  // HIGHLIGHT OPERATIONS
  Future<int> insertHighlight(Map<String, dynamic> highlight) async {
    final db = await instance.database;
    return await db.insert('highlights', highlight, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getHighlights() async {
    final db = await instance.database;
    return await db.query('highlights');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

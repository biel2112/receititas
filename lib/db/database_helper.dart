import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataHelper {
  static final DataHelper instance = DataHelper._init();
  static Database? _database;

  DataHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('receitas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE receitas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        ingredientes TEXT NOT NULL,
        modo_preparo TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ingredientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        quantidade TEXT NOT NULL,
        medida TEXT NOT NULL,
        receita_id INTEGER NOT NULL,
        FOREIGN KEY (receita_id) REFERENCES receitas (id) ON DELETE CASCADE
      )
    ''');
  }
}

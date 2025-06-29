import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotasDatabase {
  static final NotasDatabase _instance = NotasDatabase._internal();
  factory NotasDatabase() {
    return _instance;
  }

  NotasDatabase._internal();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // si la db aun no esa creada la inciailiamos
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final pathDb = await getDatabasesPath();
    final path = join(pathDb, "notas.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, contenido TEXT)',
        );
      },
    );
  }
}

import 'dart:io';

import 'package:gastosappg12/models/gasto_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbAdminGastos {
  Database? myDatabase;

  static final DbAdminGastos _instance = DbAdminGastos._();

  DbAdminGastos._();
  factory DbAdminGastos() {
    return _instance;
  }

  Future<Database?> _checkDatabase() async {
    if (myDatabase == null) {
      myDatabase = await _initDatabase();
    }
    return myDatabase;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationSupportDirectory();
    print(directory);
    String pathDatabase = join(directory.path, "gastosdb.db");
    print(pathDatabase);
    return await openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (db, version) {
        db.execute("""CREATE TABLE GASTOS(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          price REAL,
          datetime TEXT,
          type TEXT
        )""");
      },
    );
  }

  //INSERCIÓN
  Future<int> insertarGasto(GastoModel gasto) async {
    Database? db = await _checkDatabase();
    int res = await db!.insert("GASTOS", gasto.toMap());
    print(res);
    return res;
  }

  //OBTENCIÓN
  Future<List<GastoModel>> obtenerGastos() async {
    Database? db = await _checkDatabase();
    List<Map<String, dynamic>> data = await db!.query("GASTOS");
    List<GastoModel> gastosModelList =
        data.map((e) => GastoModel.fromDB(e)).toList();
    print(gastosModelList);
    return gastosModelList;
  }

  // UPDATE
  Future<int> updGasto() async {
    Database? db = await _checkDatabase();
    int res = await db!.update("GASTOS", {
      "title": "Mercado",
      "price": 100.4,
    }, where: "id=2");
    print(res);
    return res;
  }

  // DELETE
  Future<int> delGasto() async {
    Database? db = await _checkDatabase();
    int res = await db!.delete("GASTOS", where: "id=1");
    print(res);
    return res;
  }
}

import 'package:flutter/material.dart';
import 'package:gastosappg12/db/db_admin_notas.dart';
import 'package:gastosappg12/models/nota_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbExample extends StatefulWidget {
  @override
  State<DbExample> createState() => _DbExampleState();
}

class _DbExampleState extends State<DbExample> {
  List<Map<String, dynamic>>? notasList;

  // Future<Database> initDb() async {
  //   final pathDb = await getDatabasesPath();
  //   final path = join(pathDb, "notas.db");
  //   return openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (db, version) {
  //       return db.execute(
  //         'CREATE TABLE notas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, contenido TEXT)',
  //       );
  //     },
  //   );
  // }

  // Future<void> insertarNota(String titulo, String contenido) async {
  //   final db = await initDb();
  //   await db.insert("notas", {"titulo": titulo, "contenido": contenido});
  // }

  // Future<List<Map<String, dynamic>>> obtenerNotas() async {
  //   final db = await initDb();
  //   // return db.query('notas', columns: ["titulo"], where: "titulo='Ventas'");
  //   // return db.query('notas', columns: ["titulo"]);
  //   return db.rawQuery("SELECT * FROM notas ");
  //   // return db.rawQuery("SELECT titulo FROM notas WHERE titulo = 'Compas'");
  // }

  // Future<void> actualizarNota(int id, String nuevoContenido) async {
  //   final db = await initDb();
  //   await db.update(
  //     "notas",
  //     {"contenido": nuevoContenido},
  //     where: "id=?",
  //     whereArgs: [id],
  //   );
  // }

  // Future<void> eliminarNota(int id) async {
  //   final db = await initDb();
  //   db.delete("notas", where: "id=?", whereArgs: [id]);
  // }

  setNotas() async {
    // notasList = await obtenerNotas();
    setState(() {});
  }

  @override
  void initState() {
    setNotas();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //     // await initDb();
              //   },
              //   child: Text("Crear DB"),
              // ),
              ElevatedButton(
                onPressed: () async {
                  // final db = await NotasDatabase().database;

                  NotasDatabase().insertarNota(
                    NotaModel(titulo: "TITULO1", contenido: "CONENIDEO2"),
                  );
                  // await db.insert("notas", {
                  //   "titulo": "vender",
                  //   "contenido": "Vender cosas de la cochera",
                  // });

                  // await insertarNota(
                  //   "Compas",
                  //   "Comprar huevos pan y aceotuinas",
                  // );
                },
                child: Text("Insertar nota"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // await actualizarNota(1, "Este es el nuevo contenido");
                },
                child: Text("Actualizar nota"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // await eliminarNota(1);
                },
                child: Text("Eliminar nota"),
              ),

              notasList == null
                  ? Text("No hay notas")
                  : Expanded(
                    child: ListView.builder(
                      itemCount: notasList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final nota = notasList![index];
                        return ListTile(
                          title: Text(nota["titulo"] ?? "-"),
                          subtitle: Text(nota["contenido"] ?? "-"),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

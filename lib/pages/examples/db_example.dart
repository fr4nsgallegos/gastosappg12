import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbExample extends StatefulWidget {
  @override
  State<DbExample> createState() => _DbExampleState();
}

class _DbExampleState extends State<DbExample> {
  List<Map<String, dynamic>>? notasList;

  Future<Database> initDb() async {
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

  Future<void> insertarNota(String titulo, String contenido) async {
    final db = await initDb();
    await db.insert("notas", {"titulo": titulo, "contenido": contenido});
  }

  Future<List<Map<String, dynamic>>> obtenerNotas() async {
    final db = await initDb();
    return db.query('notas');
  }

  setNotas() async {
    notasList = await obtenerNotas();
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
              ElevatedButton(
                onPressed: () async {
                  await initDb();
                },
                child: Text("Crear DB"),
              ),

              ElevatedButton(
                onPressed: () async {
                  await insertarNota("Ventas", "vender mi ropa usada");
                },
                child: Text("Insertar nota"),
              ),

              notasList == null
                  ? Text("No hay notas")
                  : Expanded(
                    child: ListView.builder(
                      itemCount: notasList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final nota = notasList![index];
                        return ListTile(
                          title: Text(nota["titulo"]),
                          subtitle: Text(nota["contenido"]),
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

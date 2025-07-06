import 'package:flutter/material.dart';
import 'package:gastosappg12/db/db_admin_gastos.dart';
import 'package:gastosappg12/generated/l10n.dart';
import 'package:gastosappg12/models/gasto_model.dart';
import 'package:gastosappg12/widgets/busqueda_widget.dart';
import 'package:gastosappg12/widgets/item_widget.dart';
import 'package:gastosappg12/widgets/register_modal_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GastoModel> gastosList = [];

  Future<void> getDataFromDb() async {
    gastosList = await DbAdminGastos().obtenerGastos();
    setState(() {});
  }

  void showRegisterModal() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return RegisterModalWidget();
      },
    ).then((value) {
      getDataFromDb();
    });
  }

  @override
  void initState() {
    getDataFromDb();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showRegisterModal();
                  },
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Agregar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Ingresa tus gastos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "Gestiona tus gastos de mejor forma",
                          style: TextStyle(color: Colors.black45, fontSize: 16),
                        ),
                        Text(S.of(context).hello),
                        Text(S.of(context).helloAlguien("jhonny")),
                        BusquedaWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: gastosList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemWidget(gastosList[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

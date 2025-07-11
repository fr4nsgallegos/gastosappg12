import 'package:flutter/material.dart';
import 'package:gastosappg12/db/db_admin_gastos.dart';
import 'package:gastosappg12/models/gasto_model.dart';
import 'package:gastosappg12/models/type_model.dart';
import 'package:gastosappg12/widgets/field_modal_widget.dart';
import 'package:gastosappg12/widgets/item_type_widget.dart';

class RegisterModalWidget extends StatefulWidget {
  const RegisterModalWidget({super.key});

  @override
  State<RegisterModalWidget> createState() => _RegisterModalWidgetState();
}

class _RegisterModalWidgetState extends State<RegisterModalWidget> {
  TextEditingController titleContoller = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String typeSelected = "Alimentos";

  void showDateTimePicker() async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            colorScheme: ColorScheme.light(primary: Colors.red),
          ),
          child: child!,
        );
      },
    );
    dateController.text = datePicker.toString();
    print(dateController.text);
  }

  _buildAddButton() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          GastoModel gastoModel = GastoModel(
            title: titleContoller.text,
            price: double.parse(priceController.text),
            datetime: dateController.text,
            type: typeSelected,
          );
          DbAdminGastos().insertarGasto(gastoModel).then((value) {
            if (value > 0) {
              // SE HA INSERTADO CORRECTAMENTE
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.cyan,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  content: Text("Se ha registrado correctamente"),
                ),
              );
              Navigator.pop(context);
            }
          });
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: Text("Añadir", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Text("Registra el gasto"),
          SizedBox(height: 24),
          FieldModalWidget(
            hint: "Ingresa el título",
            controller: titleContoller,
          ),
          FieldModalWidget(
            hint: "Ingresa el monto",
            controller: priceController,
            isNumberKeyboard: true,
          ),
          FieldModalWidget(
            hint: "Ingresa la fecha",
            controller: dateController,
            isDatePicker: true,
            function: () {
              showDateTimePicker();
            },
          ),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children:
                typesList
                    .map(
                      (e) => ItemTypeWidget(
                        typeModel: e,
                        isSelected: typeSelected == e.type,
                        tap: () {
                          typeSelected = e.type;
                          setState(() {});
                        },
                      ),
                    )
                    .toList(),
          ),
          _buildAddButton(),
        ],
      ),
    );
  }
}

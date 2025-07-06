import 'package:flutter/material.dart';
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
        onPressed: () {},
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
            controller: titleContoller,
            isNumberKeyboard: true,
          ),
          FieldModalWidget(
            hint: "Ingresa la fecha",
            controller: titleContoller,
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

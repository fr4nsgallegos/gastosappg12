import 'package:flutter/material.dart';

class FieldModalWidget extends StatelessWidget {
  String hint;
  TextEditingController controller;
  bool isNumberKeyboard;
  bool isDatePicker;
  VoidCallback? function;
  FieldModalWidget({
    required this.hint,
    required this.controller,
    this.isNumberKeyboard = false,
    this.isDatePicker = false,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        onTap: function,
        controller: controller,
        keyboardType:
            isNumberKeyboard ? TextInputType.number : TextInputType.text,
        readOnly: isDatePicker,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          contentPadding: EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String label;

  TextEditingController? controller;

  TextInputType? KeyBoardType;

  Validator? validator;

  bool isSecureText;

  CustomTextFormField(
      {required this.label,
      required this.KeyBoardType,
      this.isSecureText = false,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        controller: controller,
        keyboardType: KeyBoardType,
        obscureText: isSecureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.blue, width: 2)),
          // enabledBorder: ,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        ),
      ),
    );
  }
}

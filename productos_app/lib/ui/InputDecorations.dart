import 'package:flutter/material.dart';

class  InputDecorations {

  static InputDecoration decorationInput({
    required String hinText,
    required String labelTex,
    IconData? iconData
  }) {

    return InputDecoration(

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(18, 180, 189, 1))
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(18, 180, 189, 1), width: 2)
                ),
                hintText: hinText,
                hintStyle: TextStyle(color: Colors.grey),
                labelText: labelTex,
                labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                prefixIcon: iconData != null 
                ? Icon(iconData, color: Color.fromRGBO(18, 180, 189, 1))
                : null
              );

  }

}
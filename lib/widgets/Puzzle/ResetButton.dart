import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/widgets/mycolors.dart';

class ResetButton extends StatelessWidget {

  final pref = PreferenciasUsurario();

  final VoidCallback reset;
  String text;

  ResetButton(this.reset, this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(0)
          ),
          gradient: LinearGradient(colors: [

          pref.getColor ?  MyColors.colorRosa : MyColors.colorAzul,
          pref.getColor ?  MyColors.colorRosa.withBlue(210) : MyColors.colorAzul.withGreen(210),

          ])
        ),
        child: Text(text, style: TextStyle(color: Colors.black54, fontFamily: 'RacingSansOne', fontSize: 18),),
      ),
        onTap: reset,
    );
  }
}

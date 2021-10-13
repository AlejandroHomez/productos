
import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';

class MyTitle extends StatelessWidget {
  var size;

  MyTitle(this.size);

  @override
  Widget build(BuildContext context) {
  final pref = PreferenciasUsurario();

    return Container(
      child: Text(
        "Juego de Puzzle ",
        style: TextStyle(
            fontFamily: 'RacingSansOne',
            fontSize: size.height * 0.040,
            color: Colors.black54,
            decoration: TextDecoration.none),
      ),
    );
  }
}

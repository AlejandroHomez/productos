
import 'package:flutter/material.dart';

class Move extends StatelessWidget {

  int move;

  Move(this.move);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "Movimientos: ${move}",
        style: TextStyle(
            fontFamily: 'RacingSansOne' ,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontSize: 20
        ),
      ),
    );
  }
}
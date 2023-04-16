
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Time.dart';
import 'Move.dart';

class Menu extends StatelessWidget {

  final VoidCallback reset;
  int move;
  int secondsPassed;
  var size;

  Menu(this.reset, this.move, this.secondsPassed, this.size);

  @override
  Widget build(BuildContext context) {

    // final 
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Move(move),
          Time(secondsPassed),
          //  ResetButton(reset, "Reiniciar"),
        ],
      ),
    );
  }
}
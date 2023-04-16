
import 'package:flutter/material.dart';

class Time extends StatelessWidget {

  int secondsPassed;

  Time(this.secondsPassed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "Tiempo: ${secondsPassed}",
        style: TextStyle(
          fontFamily: 'RacingSansOne',
          fontSize: 20,
          decoration: TextDecoration.none,
          color: Colors.black,
        ),
      ),
    );
  }
}
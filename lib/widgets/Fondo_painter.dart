import 'package:flutter/material.dart';
import 'package:productos_app/customsPainter/customPainter.dart';

class BackGroundHome extends StatelessWidget {
  final Widget child;

  const BackGroundHome({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

      Container(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: CustomHome(),
            )),
      Container(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: CustomHome2(),
            )),
      Container(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: CustomHome3(),
            )),


        this.child
      ],
    );
  }
}

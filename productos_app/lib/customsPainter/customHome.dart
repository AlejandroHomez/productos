import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/widgets/mycolors.dart';

class CustomHome extends CustomPainter {

  final pref = new PreferenciasUsurario();

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = pref.getColor ?  MyColors.colorRosa : MyColors.colorAzul ;


    final path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return false;
  }
}



class CustomHome2 extends CustomPainter {

  final pref = new PreferenciasUsurario();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = pref.getColor ? MyColors.colorRosa.withOpacity(0.4) : MyColors.colorAzul.withOpacity(0.4);
    final path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.48);
    path.lineTo(size.width, size.height * 0.38);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class CustomHome3 extends CustomPainter {

  final pref = new PreferenciasUsurario();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = pref.getColor ? MyColors.colorRosa.withOpacity(0.3) : MyColors.colorAzul.withOpacity(0.3);

    final path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.46);
    path.lineTo(size.width, size.height * 0.36);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

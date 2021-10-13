import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {

  final VoidCallback click;
  String? text;
  Map<int, String> imagenes = {};


  GridButton(this.text, this.click, this.imagenes);

  @override
  Widget build(BuildContext context) {

    int numero = int.parse(text!);

    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(imagenes[numero]! ),
          fit: BoxFit.cover,
          )
        ),
        onTap: click,
    );
  }
}

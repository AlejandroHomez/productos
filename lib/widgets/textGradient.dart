import 'package:flutter/material.dart';


class TextGradient extends StatelessWidget {

  final String title;
  final Gradient gradient;
  final TextStyle? stileText;

  const TextGradient(this.title, this.gradient, this.stileText);

  @override
  Widget build(BuildContext context) {

      //GRADIENT DEL TITLE APPBAR

        return ShaderMask(
              blendMode: BlendMode.srcATop,
              child: Text( title , style: stileText),
              
              shaderCallback: (rect) {

              return gradient.createShader(rect);
                
            }
       );
  }
}
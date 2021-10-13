import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/widgets/mycolors.dart';
import 'package:productos_app/widgets/widgets.dart';

class AppBarWidget extends StatelessWidget {

  final Widget child;

  const AppBarWidget({Key? key,required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

  final pref = new PreferenciasUsurario();


    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                child,

                   Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutBack,
                    builder: (context, value, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          // ..translate(value * 100 )
                          // ..translate(-100 ),
                          ..scale(value),
                        child: child,
                      );
                    },
                    child: TextGradient(
                        'Slippers',
                        LinearGradient(colors: [

                         pref.getColor ?  MyColors.colorRosa : MyColors.colorAzul,
                         pref.getColor ?  MyColors.colorRosa.withBlue(210) : MyColors.colorAzul.withGreen(210),
                        ]),
                        TextStyle(fontSize: 34, fontFamily: 'RacingSansOne')),
                  ),
                ),
              ),

                Image(image: AssetImage('assets/Logo_imagen.png'), width: 40)                
                
              ],
            ), 
      
           
            
            ClasificacionProducto()
          ],
        ),
      );
  }
}
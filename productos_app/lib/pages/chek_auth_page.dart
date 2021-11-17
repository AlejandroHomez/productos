import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/pages/pages.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/preferencias/preferencias_usuario.dart';


class CheckAuthPage extends StatefulWidget {

  @override
  _CheckAuthPageState createState() => _CheckAuthPageState();
}

class _CheckAuthPageState extends State<CheckAuthPage> {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
  final productService = Provider.of<ProductsService>(context);


    final pref = PreferenciasUsurario();


    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            
            print(pref.getEmail);
            
            if ( pref.getEmail == '' ) {

              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: ( _, __ , ___ ) => LoginPage(),
                  transitionDuration: Duration(seconds: 0)
                  )
                );
              }); 

            } 

            if(pref.getEmail != '') {

               Future.microtask(() {  
                 productService.categoriaSeleccionada = "Babuchas";

                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: ( _, __ , ___ ) => HomePage(),
                  transitionDuration: Duration(seconds: 0),
                  
                  )
                );
                
              }
              ); 
            }

            return Container();       

          },
        ),
     ),
   );
  }
}
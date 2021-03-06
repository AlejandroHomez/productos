import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productos_app/pages/Principales/Home/home_body.dart';
import 'package:productos_app/pages/Principales/Home/list_view_home.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  double valor = 0;
  late bool _colorSecundary = false;
  late List<String> _listaLikes = [];

  final pref = PreferenciasUsurario();

  @override
  void initState() {
    super.initState();
    _colorSecundary = pref.getColor!;
    _listaLikes = pref.getLikes!;
  }

  @override
  Widget build(BuildContext context) {

  final pref = PreferenciasUsurario();

  super.build(context);

    _setSelectedColor(bool valor) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('color', valor);
      _colorSecundary = valor;
      setState(() {});
    }

   _setLikes(List<String> valor) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setStringList('likes', valor);
      _listaLikes = valor;
      setState(() {});
    }

  final scoreService = Provider.of<ScoreService>(context);
  final productsService = Provider.of<ProductsService>(context);

    productsService.countProducts();
    print(productsService.cantidadProductos);

    int cantidad = productsService.cantidadProductos;

    List<int> numeros = [];


    for  (var i = 0; i < cantidad ; i++)  {
      numeros.add(0);
    }

    List<String> datos = numeros.map((i) => i.toString()).toList();

    return Scaffold(
      body: Stack(
        children: [

        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
          ),

        SafeArea(
          child: Container(
            width: 230,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [

                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0 , end: valor),
                  duration: Duration(seconds: 3),
                  curve: Curves.easeOutCirc,
                  builder: (context, value, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 10 * value)
                      ..rotateY(value * 3)
                      ,
                      child: child
                    );
                  },

                  child: GestureDetector(
                      onTap: () {
                      scoreService.loadScore();
                      Navigator.pushNamed(context, 'game');
                    },
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(200)
                        ),
                        child: Image(image: AssetImage('assets/Logo_imagen.png') ,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                 _ButtonPlay(scoreService: scoreService, pref: pref),

                SwitchListTile(
                    title: Text("App color" , style: TextStyle(color: Colors.white , fontFamily: 'RacingSansOne' , fontSize: 22 ),),
                    value: _colorSecundary,
                    
                    inactiveThumbColor: MyColors.colorAzul,
                    inactiveTrackColor: Colors.cyan.shade100,

                    activeColor: MyColors.colorRosa,
                    activeTrackColor: Colors.pink.shade100,

                    onChanged: _setSelectedColor
                    ),

                Divider(color: Colors.white),
              

                ListViewHome( () {
                    if (valor == 0) {
                      setState(() {
                        valor = 1;
                      });
                    } else {
                      setState(() {
                        valor = 0;
                      });
                    }
                  },
                )

            ],
          ),
        )
      ),

        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: valor ), 
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic, 
          builder: ( contex , double val, __ ) {
            
            final size = MediaQuery.of(context).size;

            return(
              Transform(
                alignment: Alignment.center ,
                transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setEntry(0, 3, 215 * val)
                ..rotateY( (pi / 6) * val),
            child: HomeBody(
  
                        () {
                          if (valor == 0) {
                            setState(() {
                              valor = 1;
                            });
                          } else {
                            setState(() {
                              valor = 0;
                            });
                          }
                        },
                        size
                      )
                      
                    )
                  );                  
                }
              ),
          ],
      ) ,
    );
    
  }
  
  @override
  bool get wantKeepAlive => true; 
}

class _ButtonPlay extends StatelessWidget {
  const _ButtonPlay({
    Key? key,
    required this.scoreService,
    required this.pref,
  }) : super(key: key);

  final ScoreService scoreService;
  final PreferenciasUsurario pref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      scoreService.loadScore();
      Navigator.pushNamed(context, 'game');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 14),
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          gradient: LinearGradient(
            
            colors: [
          
              pref.getColor ?  MyColors.colorRosa : MyColors.colorAzul,
              pref.getColor ?  MyColors.colorRosa.withBlue(200) : MyColors.colorAzul.withGreen(200),
            ]
            
            ),
          borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Juega" , style: TextStyle(color: Colors.white , fontFamily: 'RacingSansOne' , fontSize: 22 )),
            Icon(FontAwesomeIcons.gamepad, size: 15, color: Colors.white,),
          ],
        ),
      ),
    );
  }
}

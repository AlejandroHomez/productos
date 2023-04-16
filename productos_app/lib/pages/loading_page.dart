import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:productos_app/widgets/mycolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_mail_app/open_mail_app.dart';

import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';



class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with AutomaticKeepAliveClientMixin {
  double valor = 0;
  late bool _colorSecundary = false;

  final pref = PreferenciasUsurario();

  @override
  void initState() {
    super.initState();
    _colorSecundary = pref.getColor!;
  }

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final pref = PreferenciasUsurario();

    super.build(context);

    // if( productService.isLoading )
    //  return LoadingPage();

    _setSelectedColor(bool valor) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('color', valor);
      _colorSecundary = valor;
      setState(() {});
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
          SafeArea(
              child: Container(
            width: 230,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: valor),
                  duration: Duration(seconds: 3),
                  curve: Curves.easeOutCirc,
                  builder: (context, value, child) {
                    return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setEntry(0, 3, 10 * value)
                          ..rotateY(value * 3),
                        child: child);
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(200)),
                          child: Image(
                            image: AssetImage('assets/Logo_imagen.png'),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, 'game'),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    pref.getColor
                                        ? MyColors.colorRosa
                                        : MyColors.colorAzul,
                                    pref.getColor
                                        ? MyColors.colorRosa.withBlue(200)
                                        : MyColors.colorAzul.withGreen(200),
                                  ]),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                FontAwesomeIcons.gamepad,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SwitchListTile(
                    title: Text(
                      "App color",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RacingSansOne',
                          fontSize: 22),
                    ),
                    value: _colorSecundary,
                    inactiveThumbColor: MyColors.colorAzul,
                    inactiveTrackColor: Colors.cyan.shade100,
                    activeColor: MyColors.colorRosa,
                    activeTrackColor: Colors.pink.shade100,
                    onChanged: _setSelectedColor),
                Divider(color: Colors.white),
                SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    _Facebook(),
                    _Instagram(),
                    _Email(),
                    _Whatsapp(),
                    SizedBox(height: 20),
                    Divider(color: Colors.white),
                    if (pref.getEmail == 'alejandro.homez.97@gmail.com')
                      ListTile(
                          onTap: () {
                            authService.logout();
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          leading: Icon(Icons.logout, color: Colors.white),
                          title: Text(
                            'Salir',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'RacingSansOne',
                                fontSize: 20),
                          )),
                    SizedBox(height: 20),
                    if (pref.getEmail == 'alejandro.homez.97@gmail.com')
                      Divider(color: Colors.white),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
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
                      child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white54,
                          child: Icon(FontAwesomeIcons.exchangeAlt,
                              color: Colors.black54)

                          //  Image(image: AssetImage('assets/desliza2.gif'), width: 60)

                          ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      // color: Colors.white,
                      child: Center(
                          child: Text("Ibagué - Colombia",
                              style: TextStyle(
                                  fontFamily: 'RacingSansOne',
                                  color: Colors.white))),
                    )
                  ],
                ))
              ],
            ),
          )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: valor),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOutCubic,
              builder: (contex, double val, __) {
                return (Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 215 * val)
                      ..rotateY((pi / 6) * val),
                    child: Scaffold(
                      appBar: AppBar(
                        flexibleSpace: AppBarWidget(
                          child: GestureDetector(
                            onTap: () {
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
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(FontAwesomeIcons.exchangeAlt,
                                  color: Colors.black54),
                            ),
                            //  Image(image: AssetImage('assets/deslizar.gif'), width: 40),
                          ),
                        ),
                        toolbarHeight: 106,
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        elevation: 0,
                      ),
                      body: BackGroundHome(
                        child: RefreshIndicator(
                            onRefresh: () async {
                              productService.getProductoCategoria(
                                  productService.getCategoriaSeleccionada);
                            },
                            color: Colors.red,
                            displacement: 30,
                            strokeWidth: 3,
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  color: Colors.white,
                                )
                              ),
                            )),
                      ),

                    )));
              }),
        ],
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}

class _Whatsapp extends StatelessWidget {
  const _Whatsapp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          String mensaje =
              "¡Hola!, quiero saber mas información sobre los productos";
          String url = "whatsapp://send?phone=+573168885155&text=$mensaje";
          await canLaunch(url)
              ? launch(url)
              : print('No se puedo abrir Whatsapp');
        },
        leading: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
        title: Text('Whatsapp',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'RacingSansOne',
                fontSize: 22)));
  }
}

class _Email extends StatelessWidget {
  const _Email({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          EmailContent email = EmailContent(
            to: [
              'babuchashz@gmail.com',
            ],
            subject: 'Hola!',
            body: '¡Quiero optener mas información de los productos!',
          );

          OpenMailAppResult result = await OpenMailApp.composeNewEmailInMailApp(
              nativePickerTitle: 'Seleccione la app', emailContent: email);
          if (!result.didOpen && !result.canOpen) {
            showNoMailAppsDialog(context);
          } else if (!result.didOpen && result.canOpen) {
            showDialog(
              context: context,
              builder: (_) => MailAppPickerDialog(
                mailApps: result.options,
                emailContent: email,
              ),
            );
          }
        },
        leading: Icon(FontAwesomeIcons.at, color: Colors.white),
        title: Text(
          'E-mail',
          style: TextStyle(
              color: Colors.white, fontFamily: 'RacingSansOne', fontSize: 22),
        ));
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class _Instagram extends StatelessWidget {
  const _Instagram({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          String igllbackUrl = 'https://www.instagram.com/slippers_ibg/';

          await canLaunch(igllbackUrl)
              ? launch(igllbackUrl)
              : print('No se puedo abrir Instagram');
        },
        leading: Icon(FontAwesomeIcons.instagram, color: Colors.white),
        title: Text(
          'Instagram',
          style: TextStyle(
              color: Colors.white, fontFamily: 'RacingSansOne', fontSize: 22),
        ));
  }
}

class _Facebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          String fbProtocolUrl;
          if (Platform.isIOS) {
            fbProtocolUrl = 'fb://profile/110829431360517';
          } else {
            fbProtocolUrl = 'fb://page/110829431360517';
          }

          String fallbackUrl =
              'https://www.facebook.com/Slippers-Ib-110829431360517';

          try {
            bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

            if (!launched) {
              await launch(fallbackUrl, forceSafariVC: false);
            }
          } catch (e) {
            await launch(fallbackUrl, forceSafariVC: false);
          }
        },
        leading: Icon(FontAwesomeIcons.facebookSquare, color: Colors.white),
        title: Text(
          'Facebook',
          style: TextStyle(
              color: Colors.white, fontFamily: 'RacingSansOne', fontSize: 22),
        ));
  }
}

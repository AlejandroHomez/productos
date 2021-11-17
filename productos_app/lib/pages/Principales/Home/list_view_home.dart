import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ListViewHome extends StatefulWidget {

  final VoidCallback onTap;

  const ListViewHome(this.onTap);

  @override
  State<ListViewHome> createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    final pref = PreferenciasUsurario();
    
    return  Expanded(
        child: ListView(
      children: [
        _Facebook(),
        _Instagram(),
        _Email(),
        _Whatsapp(),
        
        Divider(color: Colors.white),
        // if (pref.getEmail == 'alejandro.homez.97@gmail.com')
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

        // if (pref.getEmail == 'alejandro.homez.97@gmail.com')

        Divider(color: Colors.white),
        SizedBox(height: 10),
        GestureDetector(
          onTap: widget.onTap,
          child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white54,
              child: Icon(FontAwesomeIcons.exchangeAlt, color: Colors.black54)

              //  Image(image: AssetImage('assets/desliza2.gif'), width: 60)

              ),
        ),
        SizedBox(height: 30),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          // color: Colors.white,
          child: Center(
              child: Text("Ibagué - Colombia",
                  style: TextStyle(
                      fontFamily: 'RacingSansOne', color: Colors.white))),
        )
      ],
    ));
  }
}


class _Whatsapp extends StatelessWidget {
  const _Whatsapp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          String mensaje = "¡Hola!,quiero saber mas información sobre los productos";

          String url = "https://wa.me/573168885155?text=$mensaje";
          // String url = "whatsapp://send?phone=+573168885155&text=$mensaje";
          await canLaunch(url)
              ? launch(url, forceWebView: false, forceSafariVC: false)
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () async {
          String url = 'https://www.instagram.com/slippers_ibg/';

          await canLaunch(url)
              ? launch(url,forceSafariVC: false)
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

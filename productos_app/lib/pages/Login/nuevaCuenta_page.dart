import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

import 'package:productos_app/ui/InputDecorations.dart';

class NewAcountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Back_loginPage(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 200),
              Card_Login(
                child: Column(
                  children: [
                    Text("Crear Cuenta",
                        style: TextStyle(
                            color: Colors.black45,
                            fontFamily: 'RacingSansOne',
                            fontSize: 35)),
                    ChangeNotifierProvider(
                        create: (_) => FormLoginProvider(), child: FormLoginNew()),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 40),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all(StadiumBorder())),
                child: Text(
                  '¡Ya tengo una cuenta!',
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 20,
                      color: Colors.black87),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class FormLoginNew extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLoginNew> {

 final pref = PreferenciasUsurario();
  late String _email = '';
  late String _password = '';


  @override
  void initState() {
    super.initState();
    _setEmail(_email);
    _setPassword(_password);
  }

   _setEmail(String valor) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', valor);
    _email = valor;
    setState(() {});
  }

   _setPassword(String valor) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('password', valor);
    _password = valor;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<FormLoginProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //Input Correo Electronico

              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.decorationInput(
                    hinText: 'ejemplo@gmail.com',
                    labelTex: 'Correo Electronico',
                    iconData: Icons.alternate_email),
                onChanged: (value) { 
                  loginForm.email = value;
                  _setEmail(value);
                  },

                validator: (value) {
                  //Validacion de correo electronico

                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Digite un correo electronico valido';
                },
              ),

              SizedBox(height: 30),

              //Input contraseña

              Stack(
                children: [
                  TextFormField(
                    autocorrect: false,
                    obscureText: loginForm.showPassword,
                    keyboardType: TextInputType.visiblePassword,

                    decoration: InputDecorations.decorationInput(
                        hinText: '*******',
                        labelTex: 'Contraseña',
                        iconData: Icons.lock_outlined),
                        
                        onChanged: (value) {
                      loginForm.password = value;
                      _setPassword(value);
                    },
                        validator: (value) {
                          return (value != null && value.length >= 6)
                              ? null
                              : 'La contraseña es incorrecta';
                        },
                  ),

                  Positioned(
                    right: 10,
                    top: 20,
                    child: GestureDetector(
                      onTap: () {
                        loginForm.showPassWord();
                      } ,
                      child:Icon( loginForm.showPassword
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined, 
                        color: Colors.black54,) ,
                    )
                    
                  )                
                  ],
              ),

              SizedBox(height: 30),

              //Boton de ingresar

              MaterialButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {

                    FocusScope.of(context).unfocus();

                        final authService = Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isvalidForm()) return;

                        loginForm.isLoading = true;

                        final String? errorMessage =  await authService.createUser(loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                        } else  {

                           NotificationsService.showSnackBar('Esta cuenta ya existe, ingrese un correo diferente');
                          loginForm.isLoading = false;
                        }

                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Color.fromRGBO(18, 180, 189, 1),
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                highlightElevation: 0,
                disabledElevation: 0,
                disabledColor: Colors.grey,
                
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  child: Text(loginForm.isLoading ? 'Espere...' : 'Ingresar',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

class Back_loginPage extends StatelessWidget {

  final Widget child;

  const Back_loginPage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
                TopBackground(),
                IconLogin(),

                this.child,
            ],
          ),
          
          ),
      ],
    );
  }
}

class TopBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: GradientBox(),
      child: Stack(
        children: [
          Positioned(child: FiguraBackTop(80) , top: 50, left: 15),
          Positioned(child: FiguraBackTop(100) , top: 100, right: 25),
          Positioned(child: FiguraBackTop(90), bottom: -25, left: 35),
          Positioned(child: FiguraBackTop(80), top: 150, left: 90),
          Positioned(child: FiguraBackTop(100), top: -50, right: 80),
          Positioned(child: FiguraBackTop(70), bottom: 2, left: 250),
        ],
      ),
    );
  }

  BoxDecoration GradientBox() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color.fromRGBO(18, 180, 189, 1),
          Color.fromRGBO(24, 210, 200, 1),
        ]
      )
    );
  }
}

class FiguraBackTop extends StatelessWidget {

  final double _size;


  const FiguraBackTop(this._size) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(30)

      ),
    );
  }
}

class IconLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Container(
            width: double.infinity,
            child: Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 120,
            )),
      ),
    );
  }
}

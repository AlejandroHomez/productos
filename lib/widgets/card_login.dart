import 'package:flutter/material.dart';

class Card_Login extends StatelessWidget {

  final Widget child;

  const Card_Login({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 30, left: 20,right: 20),
        width: double.infinity,
        // height: 300,
        decoration: _decoration(),

        child: this.child,
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 0))
        ]
      );
  }
}
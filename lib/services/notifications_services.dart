
import 'package:flutter/material.dart';

class NotificationsService {

  static GlobalKey<ScaffoldMessengerState> messagerKey =  new GlobalKey<ScaffoldMessengerState>();


  static showSnackBar(String message) {

    final scakBar = new SnackBar(

      elevation: 0,
      duration: Duration(seconds: 4),
      backgroundColor:  Color.fromRGBO(18, 190, 189, 1),
      content: Text(message , style: TextStyle(color: Colors.white, fontSize: 15),));

  messagerKey.currentState!.showSnackBar(scakBar);

  }



}
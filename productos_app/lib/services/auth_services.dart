import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{


final String _baseUrl = 'identitytoolkit.googleapis.com';
final String _firebaseToken = 'AIzaSyDrQLwwLqkbzZmZVxY0eeGEym2za-OEhiE';

String usuario = '';
String password = '';

final storage = new FlutterSecureStorage();


  Future<String?> createUser(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password' : password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key' : _firebaseToken
    });

  final resp = await http.post(url , body: json.encode(authData));
  final Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('idToken') ) {
    await storage.write(key: 'token', value: decodedResp['idToken']);
    return null;
  } else {
    return decodedResp['error']['message'];
  }

  }

  
  Future<String?> login(String email, String password) async {


    final Map<String, dynamic> authData = {
      'email': email,
      'password' : password,
      'returnSecureToken': true
    };

    this.usuario = email;
    this.password = password;


    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key' : _firebaseToken
    });

  final resp = await http.post(url , body: json.encode(authData));
  final Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('idToken') ) {
    await storage.write(key: 'token', value: decodedResp['idToken']);
    print('Estamos Adentro');
    print(usuario);
    print(this.password);
    notifyListeners();
    return null;
  } else {
    notifyListeners();
    return decodedResp['error']['message'];
  }

  

  }

  Future logout() async {
    await storage.delete(key: 'token');
    print('EstamosAfuera');
    return;

  }

  Future<String> readToken() async {
    print('Token AH:${storage.read(key: 'token').hashCode}');
    return await storage.read(key: 'token') ?? '';
  }

}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/models/score.dart';

class ScoreService extends ChangeNotifier {
  
  final storage = new FlutterSecureStorage();

   Score? score;

  final String _baseURL = 'flutter-varios-e9b19-default-rtdb.firebaseio.com';

  bool isSaving = false;
  bool isLoading = false;

  ScoreService() {
    this.loadScore();
  }

  Future saveOrCreateProduct(Score score) async {
    this.isSaving = true;
    notifyListeners();

      await this.updateScore(score);

    this.isSaving = false;
    notifyListeners();
  }

  Future<String> updateScore(Score score) async {

    final url = Uri.https(_baseURL, 'Score/12345.json');

    final resp = await http.put(url, body: score.toJson());
    
    final decodeData = resp.body;

    
    this.score =  score ;

    notifyListeners();
    return score.nombre;
  }



 Future<Score> loadScore() async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseURL, 'Score.json/' );
    final resp = await http.get(url);

    final Map<String, dynamic> scoreMap = json.decode(resp.body);

    scoreMap.forEach((key, value) { 
      final tempScore = Score.fromMap(value);
      this.score = tempScore;

    });

    this.isLoading = false;
    notifyListeners();

    print(score!.nombre);
    print(score!.movimientos);

    return this.score!;
  }




}

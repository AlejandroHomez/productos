// To parse this JSON data, do
//
//     final score = scoreFromMap(jsonString);

import 'dart:convert';

class Score {
  Score({
  required  this.movimientos,
  required  this.nombre,
  required  this.tiempo,
  });

  int movimientos;
  String nombre;
  int tiempo;

  factory Score.fromJson(String str) => Score.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Score.fromMap(Map<String, dynamic> json) => Score(
        movimientos: json["movimientos"],
        nombre: json["nombre"],
        tiempo: json["tiempo"],
      );

  Map<String, dynamic> toMap() => {
        "movimientos": movimientos,
        "nombre": nombre,
        "tiempo": tiempo,
      };
}

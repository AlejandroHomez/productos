// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    this.id,
    required this.disponible,
    required this.domicilio,
    required this.nombre,
    this.picture,
    required this.precio,
    required this.sexo,
    required this.tipo,
    required this.tallas, 
    this.reacciones,
    this.color
  });

  String? id;
  bool disponible;
  bool domicilio;
  String nombre;
  String? picture;
  double precio;
  int sexo;
  String tipo;
  List<String>? tallas;
  List<int>? reacciones  = [0,0,0,0];
  String? color;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json, {picture}) => Product(
        id        : json["id"],
        disponible: json["disponible"],
        domicilio : json["domicilio"],
        nombre    : json["nombre"],
        picture   : json["picture"],
        precio    : json["precio"].toDouble(),
        sexo      : json["sexo"],
        tipo      : json["tipo"],
        tallas    : List<String>.from(json["tallas"].map((x) => x)),
        reacciones: List<int>.from(json["reacciones"].map((x) => x)),
        color     : json["color"],


      );

  Map<String, dynamic> toMap() => {
        "id"        : id,
        "disponible": disponible,
        "domicilio" : domicilio,
        "nombre"    : nombre,
        "picture"   : picture,
        "precio"    : precio,
        "sexo"      : sexo,
        "tipo"      : tipo,
        "tallas"    : List<String>.from(tallas!.map((x) => x)),
        "reacciones": List<int>.from(reacciones!.map((x) => x)),
        "color"     : color
      };

  Product copy() => Product(

    id: this.id,
    disponible: this.disponible,
    domicilio:  this.domicilio,
    nombre: this.nombre,
    picture:  this.picture,
    precio: this.precio,
    sexo: this.sexo,
    tipo: this.tipo,
    tallas: this.tallas,
    reacciones: this.reacciones,
    color  : this.color
  );

}

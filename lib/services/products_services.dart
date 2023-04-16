import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/services/auth_services.dart';


class ProductsService extends ChangeNotifier{

final pref = PreferenciasUsurario();
AuthService authService;

  final storage = new FlutterSecureStorage();

  late int cantidadProductos = 0;
  final List<Product> products = [];

  final String _baseURL = 'flutter-varios-8d06b-default-rtdb.firebaseio.com';

  String _categoriaSeleccionada = 'Babuchas';

  File? newImage;
  bool isLoading = false;
  bool isSaving = false;
  int length = 0;

  late Product selectedProduct;

  List<String> categorias = ['Babuchas', 'Pantuflas', 'Garras'];

  Map<String, List<Product>> productsCategoria = {};

  ProductsService(this.authService) {
    // this.loadProducts();

    categorias.forEach((item) {
      this.productsCategoria[item] = [];
    });
  }

  get getCategoriaSeleccionada => this._categoriaSeleccionada;

  set categoriaSeleccionada(String valor) {
    this._categoriaSeleccionada = valor;

    this.getProductoCategoria(valor);
    notifyListeners();
  }

List<Product>? get getArticulosCategoriaSelecccionada => this.productsCategoria[this.getCategoriaSeleccionada];


 Future saveOrCreateProduct( Product product) async {
   
  this.isSaving = true;
  notifyListeners();

    if (product.id == null) {
      await this.createProduct(product);
    } else  {
      await this.updateProduct(product);
    }

  this.isSaving = false;
  notifyListeners();   

 }

 Future<String> updateProduct(Product product) async {
   
   final url = Uri.https( _baseURL, 'products/${product.id}.json');
   
   final resp = await http.put( url, body: product.toJson() );
   final decodeData = resp.body;

    final index = this.productsCategoria[getCategoriaSeleccionada]!.indexWhere((element) => element.id == product.id );

    this.productsCategoria[getCategoriaSeleccionada]![index] = product;

    notifyListeners();
    return product.id!;


 }

  Future<int> countProducts() async {

    final url = Uri.https(_baseURL, 'products.json',);

    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    this.cantidadProductos = productsMap.length;

    return productsMap.length;
  }





//  Future<List<Product>> loadProducts() async {
//     this.isLoading = true;
//     notifyListeners();

//     authService.login(pref.getEmail, pref.getPassword);

//     final url = Uri.https(_baseURL, 'products.json',
//         {'auth': await storage.read(key: 'token') ?? ''});

//     final resp = await http.get(url);

//     print('Respuesta: ${resp.body}');

//     final Map<String, dynamic> productsMap = json.decode(resp.body);

//     print('Map: ${productsMap}');

//     productsMap.forEach((key, value) {
//       final tempProduct = Product.fromMap(value);
//       tempProduct.id = key;
//       products.add(tempProduct);

//       print(products.length);
//     });

//     this.isLoading = false;
//     notifyListeners();

//     return this.products;
//   }


getProductoCategoria(String category) async {

   this.isLoading = true;
   notifyListeners();
   
      print(length);
  if ((this.productsCategoria[category]!.length == length) && (this.productsCategoria[category]!.length > 0 )) {

      this.isLoading = false;
      notifyListeners();

      return this.productsCategoria[category];
    }
    
   FirebaseDatabase.instance.reference().child("products").orderByChild("tipo").equalTo(category).once().then((DataSnapshot snap) {

    var keys = snap.value.keys;
    var data = snap.value;

    productsCategoria[category]!.clear();

    for (var individualKey in keys) {

      Product productos = Product(

        id          : individualKey.toString(),
        disponible  : data[individualKey]["disponible"] ,
        domicilio   : data[individualKey]["domicilio"] , 
        nombre      : data[individualKey]["nombre"] , 
        picture     : data[individualKey]["picture"] ,
        precio      : data[individualKey]["precio"], 
        sexo        : data[individualKey]["sexo"] , 
        tipo        : data[individualKey]["tipo"] ,
        tallas      : List<String>.from(data[individualKey]["tallas"].map((x) => x)) ,        
        reacciones  : List<int>.from(data[individualKey]["reacciones"].map((x) => x)) ,
        color       : data[individualKey]["color"] 
        );

      productsCategoria[category]!.add(productos);

      length = productsCategoria[category]!.length;
      // productsCategoria[category]!.add(productos);
      notifyListeners();

      }

   });

this.isLoading = false;
notifyListeners();

}



  Future<String> createProduct(Product product) async {

    final url = Uri.https(_baseURL, 'products.json', {
     'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.post(url, body: product.toJson());
    final decodeData = json.decode(resp.body);

    product.id = decodeData["name"];

    this.products.add(product);

    return product.id!;
  }

borrarProduct(Product product) async {

  print('Id: ${product.id}');

    final url = Uri.https(_baseURL, 'products/${product.id}.json' , {
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.delete(url, body: product.toJson());

    for (int i = 0; i < products.length; i++) {
      if (product.id == products[i].id ) {
        this.products.removeAt(i);
        
      }   
    }
    
    getProductoCategoria(getCategoriaSeleccionada);
    notifyListeners();

  }

  void updateSelectedImage(String path){

    this.selectedProduct.picture = path;
    this.newImage = File.fromUri( Uri(path: path) );

    notifyListeners();

  }


  // Future<String?> uploadStatusImage() async {
    
  //   if (newImage != null) {
  //     final Reference postImageRef =
  //         FirebaseStorage.instance.ref().child("Imagenes-Babuchas");

  //     DateTime timeKey = DateTime.now();

  //     final UploadTask uploadTask =
  //         postImageRef.child(timeKey.toString() + ".jpg").putFile(newImage!);

  //     var imageUrl = await (await uploadTask).ref.getDownloadURL();

  //     final url = imageUrl.toString();
  //     print('Image Url:${url}');

  //     return url;
  //   }
  // }

  Future<String?> uploadImage() async {
    
    if (this.newImage == null) return null; 
      this.isSaving = true;

    final url = Uri.parse('https://api.cloudinary.com/v1_1/da5wnow0k/image/upload?upload_preset=pltln4ui');

    final imageUploadRequest = http.MultipartRequest('POST' , url);

    final file = await http.MultipartFile.fromPath('file', newImage!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201 ) {

      print('Algo salio mal');
      print(resp.body);
      return null;

    }

    this.newImage = null;

    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];


  }



}
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:provider/single_child_widget.dart';

class FormProductProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  GlobalKey<SingleChildState> formKeySca = new GlobalKey<SingleChildState>();

  Product product;

  FormProductProvider(this.product);

  updateDisponible(bool value) {
    print(value);
    this.product.disponible = value;
    notifyListeners();
  }

  updateDomicilio(bool value) {
    print(value);
    this.product.domicilio = value;
    notifyListeners();
  }

  updateRadioSexo(int value){
    this.product.sexo = value;
    notifyListeners();
  }

  updateTalla(List<String> value) {
    
    if(value.isEmpty) {
      this.product.tallas = [];
    }

    this.product.tallas = value;
    notifyListeners();
  }

  updateReacciones(List<int> value){
    this.product.reacciones = value ;  
   print(product.reacciones);
   notifyListeners();
  }


  bool isValidFomr(){
    return formKey.currentState?.validate() ?? false;
  }

}
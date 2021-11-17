import 'package:flutter/material.dart';
import 'package:productos_app/models/score.dart';
import 'package:provider/single_child_widget.dart';

class FormScoreProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  GlobalKey<SingleChildState> formKeySca = new GlobalKey<SingleChildState>();

  Score score;

  FormScoreProvider(this.score);

  updateNombre(String value) {
    print(value);
    this.score.nombre = value;
    notifyListeners();
  }

  updateMovimientos(int value) {
    print(value);
    this.score.movimientos = value;
    notifyListeners();
  }

  updateTiempo(int value) {
    this.score.tiempo = value;
    notifyListeners();
  }

  bool isValidFomr() {
    return formKey.currentState?.validate() ?? false;
  }
}

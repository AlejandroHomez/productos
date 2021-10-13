import 'package:flutter/material.dart';

class FormLoginProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool showPassword = true;

  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool showPassWord(){

    if (showPassword == false) {
      showPassword = true;
      notifyListeners();
      return showPassword;
    }

    if (showPassword == true){
      showPassword = false;
      notifyListeners();
     return showPassword;
    }

    return showPassword;

  }
  

  bool isvalidForm(){

    print(formKey.currentState?.validate() ?? false);

    // print('$email - $password'); 
    notifyListeners();
    return formKey.currentState?.validate() ?? false;
  }

}
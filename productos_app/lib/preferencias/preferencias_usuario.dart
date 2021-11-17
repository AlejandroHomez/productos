import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsurario  {

  static final PreferenciasUsurario _instancia =
      new PreferenciasUsurario._internal();

  factory PreferenciasUsurario() {
    return _instancia;
  }

  PreferenciasUsurario._internal();

  late SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //Color

  get getColor {
    return _prefs.getBool('color') ?? true;
  }

  set color(bool? valor) {
    _prefs.setBool('color', valor!);
  }



  //Email

  get getEmail {
    return _prefs.getString('email') ?? 'jhon.botero@cun.edu.co';
  }

  set email(String valor) {
    _prefs.setString('email', valor);
  }


  //Contraseña
  
  get getPassword {
    return _prefs.getString('password') ?? '123456';
  }

  set password(String valor) {
    _prefs.setString('password', valor);
  }

    
  get getLikes {
    return _prefs.getStringList('likes') ?? [];
  }

  set likes(List<String> valor) {
    _prefs.setStringList('likes', valor);
  }
}

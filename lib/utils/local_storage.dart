import 'package:shared_preferences/shared_preferences.dart';

class Localstorage {
  SharedPreferences? sp;

  void callSharedPrefs() async {
    sp = await SharedPreferences.getInstance();
  }

  String? setToken() {
    callSharedPrefs();
    var token = sp!.getString('token');
    return token;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

final localStorageNew = LocalStorage._();

class LocalStorage {
  LocalStorage._();

  late SharedPreferences sp;

  Future<void> init() async {
    sp = await SharedPreferences.getInstance();
  }

  setString(String key, String val) async {
    await sp.setString(key, val);
  }

  getString(String val) {
    return sp.getString(val);
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'HttpUtils.dart';

class AppStatus {
  static AppStatus _instance;
  SharedPreferences prefs;

  static AppStatus getInstance() {
    if (_instance == null) {
      _instance = AppStatus();
    }
    return _instance;
  }

  AppStatus() {}

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveToken(token) {
    prefs.setString("token", token);
    HttpUtils.getInstance().setHeader({"Authorization": "Token $token"});
  }

  clearToken() {
    prefs.setString("token", null);
    HttpUtils.getInstance().setHeader({"Authorization": ""});
  }

  getToken() {
    return prefs.getString("token");
  }

  initHeader() async{
    await initPrefs();
    var token = getToken();

    if (token != null) {
      HttpUtils.getInstance().setHeader({"Authorization": "Token $token"});
    }
  }

  bool isLogin() {
    var token = getToken();
    return  token != null;
  }
}

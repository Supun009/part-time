import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLcalDataSource {
  Future<void> init();

  void setToken(String? token);

  String? getToken();

  void removeToken();

  void savetheme(String theme);

  String? getTheme();
}

class AuthLcalDataSourceImpl implements AuthLcalDataSource {
  late SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  String? getToken() {
    return _sharedPreferences.getString('x-auth-token');
  }

  @override
  void setToken(String? token) {
    if (token != null) {
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  @override
  void removeToken() {
    _sharedPreferences.remove('x-auth-token');
  }

  @override
  void savetheme(String theme) {
    _sharedPreferences.setString('Theme', theme);
  }

  @override
  String? getTheme() {
    return _sharedPreferences.getString('Theme');
  }
}

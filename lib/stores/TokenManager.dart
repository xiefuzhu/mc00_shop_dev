import 'package:mc00_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";
  init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  setToken(String token) async {
    final prefs = await _getInstance();
    await prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;
  }

  String getToken() {
    return _token;
  }

  removeToken() async {
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = TokenManager();

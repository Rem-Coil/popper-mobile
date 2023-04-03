import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/models/user/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = 'token';

@singleton
class TokenStorage {
  Future<void> saveToken(Token token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token.token);
  }

  Future<Token?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null ? Token(token: token) : null;
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

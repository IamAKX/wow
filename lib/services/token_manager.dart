import 'package:jwt_decode/jwt_decode.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'dart:async';

import '../main.dart';

class TokenManager {
  Future<void> saveToken(String token) async {
    await prefs.setString(PrefsKey.jwtToken, token);
  }

  Future<String?> getToken() async {
    return prefs.getString(PrefsKey.jwtToken);
  }

  Future<bool> isTokenExpired() async {
    final token = await getToken();
    if (token == null) {
      return true;
    }
    return Jwt.isExpired(token);
  }
}

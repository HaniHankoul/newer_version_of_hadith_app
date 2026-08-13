import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String tokenTypeKey = 'tokenType';

  static Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
    String? tokenType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);

    if (refreshToken != null) {
      await prefs.setString(refreshTokenKey, refreshToken);
    }

    if (tokenType != null) {
      await prefs.setString(tokenTypeKey, tokenType);
    }
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(tokenTypeKey);
  }
}

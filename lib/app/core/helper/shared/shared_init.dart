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

class UserPreferences {
  static const String primaryColorKey = 'primaryColor';
  static const String secondaryColorKey = 'secondaryColor';
  static const String fontSizeKey = 'fontSize';

  static Future<void> saveTheme({
    required int primaryColor,
    required int secondaryColor,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(primaryColorKey, primaryColor);
    await prefs.setInt(secondaryColorKey, secondaryColor);
  }

  static Future<(int?, int?)> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(primaryColorKey), prefs.getInt(secondaryColorKey));
  }

  static Future<void> saveFontSize(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(fontSizeKey, fontSize);
  }

  static Future<double?> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(fontSizeKey);
  }
}

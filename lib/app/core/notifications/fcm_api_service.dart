import 'package:dio/dio.dart';

import '../helper/shared/shared_init.dart';

class FcmApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<void> registerToken(String fcmToken) async {
    final accessToken = await AuthStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return;
    }

    await _dio.post(
      '/me/fcm-tokens',
      data: {
        'fcmToken': fcmToken,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }

  static Future<void> deleteToken(String fcmToken) async {
    final accessToken = await AuthStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return;
    }

    await _dio.delete(
      '/me/fcm-tokens',
      data: {
        'fcmToken': fcmToken,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }
}
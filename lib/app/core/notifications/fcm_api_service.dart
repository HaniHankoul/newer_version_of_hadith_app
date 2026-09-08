import 'package:dio/dio.dart';

import '../helper/shared/api_client.dart';
import '../helper/shared/shared_init.dart';

class FcmApiService {
  static final Dio _dio = ApiClient.instance.dio;

  static Future<void> registerToken(String fcmToken) async {
    final accessToken = await AuthStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return;
    }

    await _dio.post('/me/fcm-tokens', data: {'fcmToken': fcmToken});
  }

  static Future<void> deleteToken(String fcmToken) async {
    final accessToken = await AuthStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return;
    }

    await _dio.delete('/me/fcm-tokens', data: {'fcmToken': fcmToken});
  }
}

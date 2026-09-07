import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'fcm_api_service.dart';

class FcmService {
  static final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  static bool _tokenRefreshListenerStarted = false;

  static Future<void> syncCurrentToken() async {
    try {
      final token = await _messaging.getToken();

      if (token == null || token.isEmpty) {
        debugPrint('FCM: no token available');
        return;
      }

      await FcmApiService.registerToken(token);

      debugPrint('FCM: token registered with backend');

      _listenForTokenRefresh();
    } catch (e) {
      debugPrint('FCM REGISTER ERROR: $e');
    }
  }

  static void _listenForTokenRefresh() {
    if (_tokenRefreshListenerStarted) {
      return;
    }

    _tokenRefreshListenerStarted = true;

    _messaging.onTokenRefresh.listen(
      (newToken) async {
        try {
          await FcmApiService.registerToken(newToken);

          debugPrint(
            'FCM: refreshed token registered with backend',
          );
        } catch (e) {
          debugPrint('FCM TOKEN REFRESH ERROR: $e');
        }
      },
    );
  }

  static Future<void> unregisterCurrentToken() async {
    try {
      final token = await _messaging.getToken();

      if (token == null || token.isEmpty) {
        return;
      }

      await FcmApiService.deleteToken(token);

      debugPrint('FCM: token removed from backend');
    } catch (e) {
      debugPrint('FCM DELETE ERROR: $e');
    }
  }
}
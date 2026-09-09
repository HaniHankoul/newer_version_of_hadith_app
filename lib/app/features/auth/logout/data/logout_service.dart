import 'package:dio/dio.dart';

import '../../../../core/helper/shared/api_client.dart';
import '../../../../core/helper/shared/shared_init.dart';
import '../../../../core/notifications/fcm_service.dart';
import '../../login/logic/services/services.dart';

class LogoutService {
  LogoutService._();

  static Future<void> logout() async {
    try {
      await FcmService.unregisterCurrentToken();

      final refreshToken = await AuthStorage.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          await ApiClient.instance.dio.post(
            '/auth/logout',
            data: {'refreshToken': refreshToken},
          );
        } on DioException {
          // حتى لو فشل الاتصال بالباك،
          // يجب أن يكمل تسجيل الخروج محلياً.
        } catch (_) {
          // تجاهل فشل تسجيل الخروج البعيد
          // والاستمرار بتنظيف الجلسة المحلية.
        }
      }

      try {
        await GoogleLoginService.instance.signOut();
      } catch (_) {
        // المستخدم قد يكون مسجل دخول بالإيميل
        // وليس عن طريق Google.
      }
    } finally {
      await AuthStorage.clearTokens();
    }
  }
}

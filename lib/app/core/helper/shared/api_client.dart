import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'shared_init.dart';

class ApiClient {
  ApiClient._()
    : _refreshDio = Dio(
        BaseOptions(
          baseUrl: 'https://api.jamilhelal.me/api/v1',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {'Accept': 'application/json'},
        ),
      ) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.jamilhelal.me/api/v1',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            if (_isAuthRequest(options.path)) {
              handler.next(options);
              return;
            }

            var accessToken = await AuthStorage.getAccessToken();

            final refreshToken = await AuthStorage.getRefreshToken();

            if ((accessToken == null || accessToken.isEmpty) &&
                refreshToken != null &&
                refreshToken.isNotEmpty) {
              final refreshed = await _refreshTokens();

              if (refreshed) {
                accessToken = await AuthStorage.getAccessToken();
              }
            } else if (accessToken != null &&
                accessToken.isNotEmpty &&
                _isTokenExpiredOrAboutToExpire(accessToken) &&
                refreshToken != null &&
                refreshToken.isNotEmpty) {
              final refreshed = await _refreshTokens();

              if (refreshed) {
                accessToken = await AuthStorage.getAccessToken();
              }
            }

            if (accessToken != null && accessToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            } else {
              options.headers.remove('Authorization');
            }

            handler.next(options);
          } catch (_) {
            handler.next(options);
          }
        },

        onError: (error, handler) async {
          final requestOptions = error.requestOptions;

          final statusCode = error.response?.statusCode;

          final alreadyRetried =
              requestOptions.extra['_retriedAfterRefresh'] == true;

          if (statusCode != 401 ||
              alreadyRetried ||
              _isAuthRequest(requestOptions.path)) {
            handler.next(error);
            return;
          }

          final refreshToken = await AuthStorage.getRefreshToken();

          if (refreshToken == null || refreshToken.isEmpty) {
            await AuthStorage.clearTokens();

            handler.next(error);
            return;
          }

          final refreshed = await _refreshTokens();

          if (!refreshed) {
            handler.next(error);
            return;
          }

          final newAccessToken = await AuthStorage.getAccessToken();

          if (newAccessToken == null || newAccessToken.isEmpty) {
            handler.next(error);
            return;
          }

          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          requestOptions.extra['_retriedAfterRefresh'] = true;

          try {
            final response = await dio.fetch<dynamic>(requestOptions);

            handler.resolve(response);
          } on DioException catch (retryError) {
            handler.next(retryError);
          } catch (_) {
            handler.next(error);
          }
        },
      ),
    );
  }

  static final ApiClient instance = ApiClient._();

  late final Dio dio;

  final Dio _refreshDio;

  Future<bool>? _refreshFuture;

  Future<bool> _refreshTokens() {
    final activeRefresh = _refreshFuture;

    if (activeRefresh != null) {
      return activeRefresh;
    }

    final future = _performRefresh();

    _refreshFuture = future;

    future.whenComplete(() {
      if (identical(_refreshFuture, future)) {
        _refreshFuture = null;
      }
    });

    return future;
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await AuthStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final response = await _refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200) {
        await AuthStorage.clearTokens();
        return false;
      }

      final responseData = response.data;

      if (responseData is! Map) {
        await AuthStorage.clearTokens();
        return false;
      }

      final dynamic rawPayload = responseData['data'] is Map
          ? responseData['data']
          : responseData;

      if (rawPayload is! Map) {
        await AuthStorage.clearTokens();
        return false;
      }

      final payload = Map<String, dynamic>.from(rawPayload);

      final accessToken = payload['accessToken']?.toString();

      final newRefreshToken = payload['refreshToken']?.toString();

      final tokenType = payload['tokenType']?.toString();

      if (accessToken == null ||
          accessToken.isEmpty ||
          newRefreshToken == null ||
          newRefreshToken.isEmpty) {
        await AuthStorage.clearTokens();
        return false;
      }

      await AuthStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
        tokenType: tokenType,
      );

      return true;
    } on DioException {
      await AuthStorage.clearTokens();
      return false;
    } catch (_) {
      await AuthStorage.clearTokens();
      return false;
    }
  }

  bool _isTokenExpiredOrAboutToExpire(String token) {
    try {
      final parts = token.split('.');

      if (parts.length != 3) {
        return false;
      }

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      if (payload is! Map) {
        return false;
      }

      final exp = payload['exp'];

      if (exp is! num) {
        return false;
      }

      final expiration = DateTime.fromMillisecondsSinceEpoch(
        exp.toInt() * 1000,
        isUtc: true,
      );

      final refreshBefore = DateTime.now().toUtc().add(
        const Duration(seconds: 30),
      );

      return expiration.isBefore(refreshBefore);
    } catch (_) {
      return false;
    }
  }

  bool _isAuthRequest(String path) {
    return path.contains('/auth/login') ||
        path.contains('/auth/google') ||
        path.contains('/auth/register') ||
        path.contains('/auth/refresh');
  }
}

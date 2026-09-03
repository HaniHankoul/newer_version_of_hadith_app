import 'package:dio/dio.dart';

import '../model/fake_hadith_response.dart';

class FakeHadithRepo {
  final Dio _dio;

  FakeHadithRepo({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://api.jamilhelal.me/api/v1',
              connectTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  Future<FakeHadithPage> getFakeHadith({
    required int page,
    required int size,
  }) async {
    return _fetch(page: page, size: size);
  }

  Future<FakeHadithPage> searchFakeHadith({
    required String query,
    required int page,
    required int size,
  }) async {
    return _fetch(page: page, size: size, query: query);
  }

  Future<FakeHadithPage> _fetch({
    required int page,
    required int size,
    String? query,
  }) async {
    try {
      final response = await _dio.get(
        '/fake-ahadith',
        queryParameters: {'page': page, 'size': size},
        data: query == null ? null : {'query': query},
      );
      return FakeHadithPage.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          throw Exception(message.trim());
        }
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }

      throw Exception('Failed to load fake hadiths');
    }
  }
}

import 'package:dio/dio.dart';

import '../../../helper/shared/shared_init.dart';
import '../models/search_history_model.dart';

class SearchHistoryRepo {
  SearchHistoryRepo({Dio? dio}) : _dio = dio ?? _createDio();

  final Dio _dio;

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://api.jamilhelal.me/api/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  Future<List<SearchHistoryModel>> getSearchHistory({
    required String source,
    String keyword = '',
    int limit = 5,
  }) async {
    final token = await AuthStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('No access token found');
    }

    try {
      final response = await _dio.get(
        '/me/search-history',
        queryParameters: {'source': source, 'keyword': keyword, 'limit': limit},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return _parseHistory(response.data);
    } on DioException catch (error) {
      final data = error.response?.data;
      if (data is Map) {
        final message = data['message'] ?? data['error'];
        if (message != null && message.toString().trim().isNotEmpty) {
          throw Exception(message.toString().trim());
        }
      }
      throw Exception(error.message ?? 'Failed to load search history');
    }
  }

  Future<void> clearHistory() async {
    await _sendHistoryDelete('/me/search-history');
  }

  Future<void> deleteHistoryItem(String searchHistoryId) async {
    final id = searchHistoryId.trim();
    if (id.isEmpty) throw Exception('Search history id is required');
    await _sendHistoryDelete('/me/search-history/$id');
  }

  Future<void> _sendHistoryDelete(String path) async {
    final token = await AuthStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('No access token found');
    }

    try {
      await _dio.delete(
        path,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (error) {
      final data = error.response?.data;
      if (data is Map) {
        final message = data['message'] ?? data['error'];
        if (message != null && message.toString().trim().isNotEmpty) {
          throw Exception(message.toString().trim());
        }
      }
      throw Exception(error.message ?? 'Failed to clear search history');
    }
  }

  List<SearchHistoryModel> _parseHistory(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map(
            (item) =>
                SearchHistoryModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    }

    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      for (final key in ['data', 'items', 'results', 'content']) {
        final value = map[key];
        if (value is List) {
          return _parseHistory(value);
        }
      }
    }

    throw const FormatException('Unexpected search history response format');
  }
}

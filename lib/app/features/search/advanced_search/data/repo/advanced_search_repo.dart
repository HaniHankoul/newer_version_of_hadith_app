import 'package:dio/dio.dart';

import '../../../../home/data/models/search_model.dart';
import '../../../../home/data/models/search_query_model.dart';

import '../models/search_filters_model.dart';

class AdvancedSearchApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<FilterModel> getFilters() async {
    try {
      final response = await dio.get('/search/filters');
      return FilterModel.fromJson(response.data as Map<String, dynamic>);
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

      throw Exception('Failed to load search filters');
    }
  }

  Future<SearchResponseModel> search(SearchBodyModel body) async {
    try {
      final response = await dio.post('/ahadith/search', data: body.toJson());
      return SearchResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
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

      throw Exception('Failed to search hadiths');
    }
  }
}

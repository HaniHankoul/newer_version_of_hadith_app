import 'package:dio/dio.dart';

import '../../../../core/helper/shared/api_client.dart';
import '../models/questions_model_response.dart';

class QuestionsRepo {
  final Dio _dio = ApiClient.instance.dio;

  dynamic _extractQuestionPayload(dynamic data) {
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);

      if (map.containsKey('data')) {
        return map['data'];
      }

      if (map.containsKey('question')) {
        return map['question'];
      }

      if (map.containsKey('questions')) {
        return map['questions'];
      }

      return map;
    }

    if (data is List && data.isNotEmpty) {
      return data.first;
    }

    return data;
  }

  Future<List<QuestionModelResponse>> getQuestions() async {
    try {
      final response = await _dio.get('/me/questions');

      if (response.statusCode == 200) {
        final data = response.data;

        final items = data is Map && data['data'] is List
            ? data['data'] as List
            : data as List;

        return items
            .map(
              (item) => QuestionModelResponse.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList();
      }

      throw Exception('Failed to fetch questions');
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Questions request failed');
    }
  }

  Future<QuestionModelResponse> sendMessage(String query) async {
    try {
      final cleanQuery = query.trim();

      if (cleanQuery.isEmpty) {
        throw Exception('Question cannot be empty');
      }

      final response = await _dio.post(
        '/me/questions',
        data: {'askerText': cleanQuery},
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final payload = _extractQuestionPayload(response.data);

        if (payload is Map<String, dynamic>) {
          return QuestionModelResponse.fromJson(payload);
        }

        if (payload is Map) {
          return QuestionModelResponse.fromJson(
            Map<String, dynamic>.from(payload),
          );
        }

        return QuestionModelResponse(askerText: cleanQuery);
      }

      throw Exception(
        response.data is Map && response.data['message'] != null
            ? response.data['message'].toString()
            : 'Failed to send question',
      );
    } on DioException catch (e) {
      final errorMap = e.response?.data;

      if (errorMap is Map) {
        final message =
            errorMap['message'] ?? errorMap['error'] ?? errorMap['errors'];

        throw Exception(
          message?.toString() ?? e.message ?? 'Question send failed',
        );
      }

      throw Exception(e.message ?? 'Question send failed');
    }
  }

  Future<void> deleteQuestion(String questionId) async {
    try {
      final id = questionId.trim();

      if (id.isEmpty) {
        throw Exception('Question id is required');
      }

      final response = await _dio.delete('/me/questions/$id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw Exception(
        response.data is Map && response.data['message'] != null
            ? response.data['message'].toString()
            : 'Failed to delete question',
      );
    } on DioException catch (e) {
      final errorMap = e.response?.data;

      if (errorMap is Map) {
        final message =
            errorMap['message'] ?? errorMap['error'] ?? errorMap['errors'];

        throw Exception(
          message?.toString() ?? e.message ?? 'Delete question failed',
        );
      }

      throw Exception(e.message ?? 'Delete question failed');
    }
  }
}

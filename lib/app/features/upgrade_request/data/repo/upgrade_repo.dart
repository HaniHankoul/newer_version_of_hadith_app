import 'package:dio/dio.dart';

import '../../../../core/helper/shared/shared_init.dart';
import '../models/upgrade_model_response.dart';

class UpgradeRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<UpgradeModelResponse?> getUpgradeRequest() async {
    try {
      final response = await _dio.get(
        '/me/upgrade-requests',
        options: Options(headers: {'Authorization': 'Bearer ${await _token}'}),
      );

      if (response.statusCode == 200) {
        final payload = response.data is Map && response.data['data'] is Map
            ? response.data['data']
            : response.data;

        return UpgradeModelResponse.fromJson(
          Map<String, dynamic>.from(payload as Map),
        );
      }

      throw Exception(
        _messageFrom(response.data) ?? 'Failed to fetch upgrade request',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }

      throw Exception(
        _messageFrom(e.response?.data) ?? e.message ?? 'Upgrade request failed',
      );
    }
  }

  Future<UpgradeModelResponse> submitUpgradeRequest({
    required String filePath,
    required String fileName,
    required String notes,
  }) async {
    try {
      final cleanNotes = notes.trim();

      final data = <String, dynamic>{
        'document': await MultipartFile.fromFile(filePath, filename: fileName),
      };

      if (cleanNotes.isNotEmpty) {
        data['notes'] = cleanNotes;
      }

      final response = await _dio.post(
        '/me/upgrade-requests',
        data: FormData.fromMap(data),
        options: Options(
          headers: {'Authorization': 'Bearer ${await _token}'},
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final payload = response.data is Map && response.data['data'] is Map
            ? response.data['data']
            : response.data;

        return UpgradeModelResponse.fromJson(
          Map<String, dynamic>.from(payload as Map),
        );
      }

      throw Exception(
        _messageFrom(response.data) ?? 'Failed to send upgrade request',
      );
    } on DioException catch (e) {
      throw Exception(
        _messageFrom(e.response?.data) ?? e.message ?? 'Upgrade request failed',
      );
    }
  }

  Future<String> get _token async {
    final token = await AuthStorage.getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('No access token found');
    }

    return token;
  }

  String? _messageFrom(dynamic data) {
    if (data is Map) {
      final message = data['message'] ?? data['error'] ?? data['errors'];

      return message?.toString();
    }

    return null;
  }
}

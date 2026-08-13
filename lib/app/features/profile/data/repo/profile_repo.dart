import 'package:dio/dio.dart';

import '../../../../core/helper/shared/shared_init.dart';
import '../models/profile_response_model.dart';

class ProfileRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<ProfileResponse> getProfile() async {
    try {
      final token = await AuthStorage.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No access token found');
      }

      final response = await _dio.get(
        '/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data;

      if (response.statusCode == 200) {
        // If backend returns: { "data": {...} }
        final profileJson =
            data is Map<String, dynamic> && data.containsKey('data')
            ? data['data']
            : data;

        return ProfileResponse.fromJson(profileJson);
      }

      throw Exception(
        data is Map<String, dynamic> && data['message'] != null
            ? data['message'].toString()
            : 'Failed to fetch profile',
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data is Map<String, dynamic> &&
                e.response?.data['message'] != null
            ? e.response!.data['message'].toString()
            : e.message ?? 'Profile request failed',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

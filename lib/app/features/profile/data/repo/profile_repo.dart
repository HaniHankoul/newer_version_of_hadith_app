import 'package:dio/dio.dart';

import '../../../../core/helper/shared/api_client.dart';
import '../models/profile_response_model.dart';

class ProfileRepo {
  final Dio _dio = ApiClient.instance.dio;

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await _dio.get('/me');

      final data = response.data;

      if (response.statusCode == 200) {
        final profileJson =
            data is Map<String, dynamic> && data.containsKey('data')
            ? data['data']
            : data;

        return ProfileResponse.fromJson(
          Map<String, dynamic>.from(profileJson as Map),
        );
      }

      throw Exception(
        data is Map && data['message'] != null
            ? data['message'].toString()
            : 'Failed to fetch profile',
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data is Map && e.response?.data['message'] != null
            ? e.response!.data['message'].toString()
            : e.message ?? 'Profile request failed',
      );
    }
  }

  Future<ProfileResponse> updateProfile({
    required String name,
    required String gender,
    required String birthDate,
  }) async {
    try {
      final response = await _dio.put(
        '/me',
        data: {
          'name': name.trim(),
          'gender': gender.trim(),
          'birthDate': birthDate.trim(),
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final profileJson = data is Map && data['data'] is Map
            ? data['data']
            : data;

        return ProfileResponse.fromJson(
          Map<String, dynamic>.from(profileJson as Map),
        );
      }

      throw Exception(
        response.data is Map && response.data['message'] != null
            ? response.data['message'].toString()
            : 'Failed to update profile',
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data is Map && e.response?.data['message'] != null
            ? e.response!.data['message'].toString()
            : e.message ?? 'Profile update failed',
      );
    }
  }
}

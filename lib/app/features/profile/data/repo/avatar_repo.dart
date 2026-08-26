import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helper/shared/shared_init.dart';
import '../models/avatar_model.dart';

class AvatarRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<Avatarmodel> uploadAvatar(XFile image) async {
    try {
      final token = await AuthStorage.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No access token found');
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path, filename: image.name),
      });
      final response = await _dio.post(
        '/me/profile-image',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final avatarJson = data is Map<String, dynamic> && data['data'] is Map
            ? Map<String, dynamic>.from(data['data'] as Map)
            : Map<String, dynamic>.from(data as Map);
        return Avatarmodel.fromJson(avatarJson);
      }

      throw Exception(
        'Upload failed (${response.statusCode}): '
        '${_messageFrom(response.data) ?? response.data}',
      );
    } on DioException catch (e) {
      throw Exception(
        'Upload failed (${e.response?.statusCode ?? 'network'}): '
        '${_messageFrom(e.response?.data) ?? e.response?.data ?? e.message ?? 'Image upload failed'}',
      );
    }
  }

  Future<void> deleteAvatar() async {
    try {
      final token = await AuthStorage.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('No access token found');
      }

      final response = await _dio.delete(
        '/me/profile-image',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
          'Delete failed (${response.statusCode}): '
          '${_messageFrom(response.data) ?? response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Delete failed (${e.response?.statusCode ?? 'network'}): '
        '${_messageFrom(e.response?.data) ?? e.response?.data ?? e.message ?? 'Image deletion failed'}',
      );
    }
  }

  String? _messageFrom(dynamic data) {
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return null;
  }
}

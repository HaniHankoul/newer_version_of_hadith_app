import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helper/shared/api_client.dart';
import '../models/avatar_model.dart';

class AvatarRepo {
  final Dio _dio = ApiClient.instance.dio;

  Future<Avatarmodel> uploadAvatar(XFile image) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path, filename: image.name),
      });

      final response = await _dio.post(
        '/me/profile-image',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
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
      final response = await _dio.delete('/me/profile-image');

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

import 'package:dio/dio.dart';

import '../../../../core/helper/shared/api_client.dart';
import '../models/favorite_model.dart';

class FavoriteRepo {
  final Dio _dio = ApiClient.instance.dio;

  Future<FavoriteModel> getFavorites() async {
    try {
      final response = await _dio.get('/me/favorites');

      if (response.statusCode == 200) {
        return FavoriteModel.fromJson(_extractMap(response.data));
      }

      throw Exception(
        _errorMessage(response.data, 'Failed to fetch favorites'),
      );
    } on DioException catch (e) {
      throw Exception(
        _errorMessage(
          e.response?.data,
          e.message ?? 'Favorites request failed',
        ),
      );
    }
  }

  Future<bool> addFavorite(String hadithId) async {
    final id = hadithId.trim();

    if (id.isEmpty) {
      throw Exception('Hadith id is required');
    }

    try {
      final favorites = await getFavorites();

      final alreadyFavorite =
          favorites.items?.any((item) => item.id == id) ?? false;

      if (alreadyFavorite) {
        return false;
      }

      final response = await _dio.post('/me/favorites/$id');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      throw Exception(_errorMessage(response.data, 'Failed to add favorite'));
    } on DioException catch (e) {
      throw Exception(
        _errorMessage(e.response?.data, e.message ?? 'Add favorite failed'),
      );
    }
  }

  Future<void> removeFavorite(String hadithId) async {
    final id = hadithId.trim();

    if (id.isEmpty) {
      throw Exception('Hadith id is required');
    }

    try {
      final response = await _dio.delete('/me/favorites/$id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw Exception(
        _errorMessage(response.data, 'Failed to remove favorite'),
      );
    } on DioException catch (e) {
      throw Exception(
        _errorMessage(e.response?.data, e.message ?? 'Remove favorite failed'),
      );
    }
  }

  Map<String, dynamic> _extractMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      final payload = data['data'];

      if (payload is Map) {
        return Map<String, dynamic>.from(payload);
      }

      return data;
    }

    throw Exception('Unexpected favorites response format');
  }

  String _errorMessage(dynamic data, String fallback) {
    if (data is Map) {
      final message = data['message'] ?? data['error'] ?? data['errors'];

      if (message != null) {
        return message.toString();
      }
    }

    return fallback;
  }
}

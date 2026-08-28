import 'package:dio/dio.dart';

import '../../../../core/helper/shared/shared_init.dart';
import '../models/favorite_model.dart';

class FavoriteRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<FavoriteModel> getFavorites() async {
    try {
      final token = await _accessToken();
      final response = await _dio.get(
        '/me/favorites',
        options: _authOptions(token),
      );

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
    if (id.isEmpty) throw Exception('Hadith id is required');

    try {
      final token = await _accessToken();
      final favorites = await getFavorites();
      final alreadyFavorite =
          favorites.items?.any((item) => item.id == id) ?? false;

      if (alreadyFavorite) {
        return false;
      }

      final response = await _dio.post(
        '/me/favorites/$id',
        options: _authOptions(token),
      );

      if (response.statusCode == 200 || response.statusCode == 201) return true;

      throw Exception(_errorMessage(response.data, 'Failed to add favorite'));
    } on DioException catch (e) {
      throw Exception(
        _errorMessage(e.response?.data, e.message ?? 'Add favorite failed'),
      );
    }
  }

  Future<void> removeFavorite(String hadithId) async {
    final id = hadithId.trim();
    if (id.isEmpty) throw Exception('Hadith id is required');

    try {
      final token = await _accessToken();
      final response = await _dio.delete(
        '/me/favorites/$id',
        options: _authOptions(token),
      );

      if (response.statusCode == 200 || response.statusCode == 204) return;

      throw Exception(
        _errorMessage(response.data, 'Failed to remove favorite'),
      );
    } on DioException catch (e) {
      throw Exception(
        _errorMessage(e.response?.data, e.message ?? 'Remove favorite failed'),
      );
    }
  }

  Future<String> _accessToken() async {
    final token = await AuthStorage.getAccessToken();
    if (token == null || token.isEmpty)
      throw Exception('No access token found');
    return token;
  }

  Options _authOptions(String token) =>
      Options(headers: {'Authorization': 'Bearer $token'});

  Map<String, dynamic> _extractMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      final payload = data['data'];
      if (payload is Map) return Map<String, dynamic>.from(payload);
      return data;
    }
    throw Exception('Unexpected favorites response format');
  }

  String _errorMessage(dynamic data, String fallback) {
    if (data is Map) {
      final message = data['message'] ?? data['error'] ?? data['errors'];
      if (message != null) return message.toString();
    }
    return fallback;
  }
}

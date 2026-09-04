import 'package:dio/dio.dart';

import '../../../../core/models/hadith_detail_model.dart';

class HadithDetailRepo {
  HadithDetailRepo({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://api.jamilhelal.me/api/v1',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  final Dio _dio;

  Future<HadithDetailModel> getHadithDetail(String hadithId) async {
    try {
      final response = await _dio.get('/ahadith/$hadithId');
      return HadithDetailModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Failed to load hadith detail');
    }
  }
}

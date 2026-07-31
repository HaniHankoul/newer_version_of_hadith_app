import 'package:dio/dio.dart';

import '../models/search_model.dart';

class SearchApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Searchmodel> search() async {
    try {
      final response = await dio.post("/api/v1/ahadith/search");
      print('*****************************************');
      return Searchmodel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "search failed");
    }
  }
}

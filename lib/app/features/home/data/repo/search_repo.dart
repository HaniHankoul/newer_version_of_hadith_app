import 'package:dio/dio.dart';

import '../models/search_model.dart';
import '../models/search_query_model.dart';

class SearchApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me/api/v1",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<SearchResponseModel> getFilters(SearchBodyModel body) async {
    try {
      final response = await dio.post("/ahadith/search", data: body.toJson());
      print("search response: ${response.data}");
      return SearchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "search failed");
    }
  }
}

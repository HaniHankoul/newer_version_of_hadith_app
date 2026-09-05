import 'package:dio/dio.dart';

import '../../../../core/helper/shared/shared_init.dart';
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
      final token = await AuthStorage.getAccessToken();
      final response = await dio.post(
        "/ahadith/search",
        data: body.toJson(),
        options: Options(
          headers: {
            "Accept": "application/json",
            if (token != null && token.isNotEmpty)
              "Authorization": "Bearer $token",
          },
        ),
      );
      print("search response: ${response.data}");
      return SearchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "search failed");
    }
  }
}

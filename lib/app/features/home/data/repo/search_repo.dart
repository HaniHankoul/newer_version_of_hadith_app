import 'package:dio/dio.dart';

class SearchApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me/api/v1",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  // Future<SearchModel> search() async {
  //   try {
  //     final response = await dio.post("/ahadith/search");
  //     return SearchModel.fromJson(response.data);
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data ?? "search failed");
  //   }
  // }
}

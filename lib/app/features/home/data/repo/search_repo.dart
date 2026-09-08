import 'package:dio/dio.dart';

import '../../../../core/helper/shared/api_client.dart';
import '../models/search_model.dart';
import '../models/search_query_model.dart';

class SearchApiService {
  final Dio dio = ApiClient.instance.dio;

  Future<SearchResponseModel> getFilters(SearchBodyModel body) async {
    try {
      final response = await dio.post(
        '/ahadith/search',
        data: body.toJson(),
        options: Options(headers: {'Accept': 'application/json'}),
      );

      return SearchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'search failed');
    }
  }
}

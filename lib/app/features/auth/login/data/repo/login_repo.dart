import 'package:dio/dio.dart';
import '../models/login_model.dart';
import '../models/login_model_res.dart';

class LoginApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Loginmodelresponse> login(Loginmodel model) async {
    try {
      final response = await dio.post(
        "/api/v1/auth/login",
        data: model.toJson(),
      );
      print(response.data);
      return Loginmodelresponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Login failed");
    }
  }
}

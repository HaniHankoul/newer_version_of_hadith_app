import 'package:dio/dio.dart';
import '../models/login_model.dart';
import '../models/login_model_res.dart';

class LoginApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me/api/v1",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Loginmodelresponse> login(Loginmodel model) async {
    try {
      final response = await dio.post("/auth/login", data: model.toJson());
      return Loginmodelresponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Login failed");
    }
  }
}

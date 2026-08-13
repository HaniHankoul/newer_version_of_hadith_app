import 'package:dio/dio.dart';

import '../models/signup_model.dart';
import '../models/signup_model_res.dart';

class SignupApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me/api/v1",
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 25),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Signupmodelresponse> signup(Signupmodel model) async {
    try {
      final response = await dio.post("/auth/register", data: model.toJson());
      return Signupmodelresponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Signup failed");
    }
  }
}

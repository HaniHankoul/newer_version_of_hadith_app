import 'package:dio/dio.dart';
import '../models/login_model.dart';
import '../models/login_model_res.dart';

class LoginApiService {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.jamilhelal.me/api/v1",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 20),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Loginmodelresponse> login(Loginmodel model) async {
    try {
      final response = await dio.post("/auth/login", data: model.toJson());
      return Loginmodelresponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data["message"];
        if (message is String && message.trim().isNotEmpty) {
          throw Exception(message.trim());
        }
      }

      if (data is String && data.trim().isNotEmpty) {
        throw Exception(data.trim());
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        final details = e.message;
        throw Exception(
          details == null || details.trim().isEmpty
              ? "Unable to connect to the server"
              : "Unable to connect to the server: ${details.trim()}",
        );
      }

      throw Exception("Login failed");
    }
  }
}

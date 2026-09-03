import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../model/muhaddith_model.dart';

class MuhaddithRepo {
  final Dio _dio;

  MuhaddithRepo({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://api.jamilhelal.me/api/v1',
              connectTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
              headers: {'Accept': 'application/xml, application/json'},
            ),
          );

  Future<List<MuhaddithModel>> getMuhaddiths() async {
    try {
      final response = await _dio.get('/muhaddiths');
      return _parseMuhaddiths(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          throw Exception(message.trim());
        }
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      throw Exception('Failed to load muhaddiths');
    } on FormatException {
      throw Exception('Invalid muhaddiths response');
    }
  }

  List<MuhaddithModel> _parseMuhaddiths(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map(
            (item) => MuhaddithModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    }
    if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['muhaddiths'] ?? data['data'];
      if (items is List) {
        return items
            .whereType<Map>()
            .map(
              (item) =>
                  MuhaddithModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }
    }
    if (data is String) {
      final document = XmlDocument.parse(data);
      return document.descendants
          .whereType<XmlElement>()
          .where((element) => element.name.local == 'item')
          .map(
            (item) => MuhaddithModel(
              serialNumber: int.tryParse(
                item.getElement('serialNumber')?.innerText ?? '',
              ),
              name: item.getElement('name')?.innerText,
              about: item.getElement('about')?.innerText,
            ),
          )
          .toList();
    }
    throw const FormatException('Unsupported muhaddiths response');
  }
}

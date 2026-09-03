import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../model/rawi_model.dart';

class RawiRepo {
  final Dio _dio;

  RawiRepo({Dio? dio})
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

  Future<List<RawiModel>> getRawis() async {
    try {
      final response = await _dio.get('/rawis');
      return _parseRawis(response.data);
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
      throw Exception('Failed to load rawis');
    } on FormatException {
      throw Exception('Invalid rawis response');
    }
  }

  List<RawiModel> _parseRawis(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map((item) => RawiModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['rawis'] ?? data['data'];
      if (items is List) {
        return items
            .whereType<Map>()
            .map((item) => RawiModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
    }
    if (data is String) {
      final document = XmlDocument.parse(data);
      return document.descendants
          .whereType<XmlElement>()
          .where((element) => element.name.local == 'item')
          .map(
            (item) => RawiModel(
              serialNumber: int.tryParse(
                item.getElement('serialNumber')?.innerText ?? '',
              ),
              name: item.getElement('name')?.innerText,
              about: item.getElement('about')?.innerText,
            ),
          )
          .toList();
    }
    throw const FormatException('Unsupported rawis response');
  }
}

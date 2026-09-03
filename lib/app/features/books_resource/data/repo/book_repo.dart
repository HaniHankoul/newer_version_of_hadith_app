import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../models/book_model.dart';
import '../models/book_response.dart';

class BookRepo {
  final Dio _dio;

  BookRepo({Dio? dio})
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

  Future<List<BookModel>> getBooks() async {
    try {
      final response = await _dio.get('/books');
      return _parseBooks(response.data);
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
      throw Exception('Failed to load books');
    } on FormatException {
      throw Exception('Invalid books response');
    }
  }

  Future<BookResponse> getBookHadiths({
    required String bookId,
    required int page,
    int size = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/books/$bookId/ahadith',
        queryParameters: {'page': page, 'size': size},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.data is! Map) {
        throw const FormatException('Unsupported book hadiths response');
      }
      return BookResponse.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
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
      throw Exception('Failed to load book hadiths');
    } on FormatException {
      throw Exception('Invalid book hadiths response');
    }
  }

  List<BookModel> _parseBooks(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map((item) => BookModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['books'] ?? data['data'];
      if (items is List) {
        return items
            .whereType<Map>()
            .map((item) => BookModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
    }
    if (data is String) {
      final document = XmlDocument.parse(data);
      return document.descendants
          .whereType<XmlElement>()
          .where((element) => element.name.local == 'item')
          .map(
            (item) => BookModel(
              id: item.getElement('id')?.innerText,
              name: item.getElement('name')?.innerText,
              muhaddith: _parseMuhaddith(item.getElement('muhaddith')),
            ),
          )
          .toList();
    }
    throw const FormatException('Unsupported books response');
  }

  Muhaddith? _parseMuhaddith(XmlElement? element) {
    if (element == null) return null;
    return Muhaddith(
      id: element.getElement('id')?.innerText,
      name: element.getElement('name')?.innerText,
    );
  }
}

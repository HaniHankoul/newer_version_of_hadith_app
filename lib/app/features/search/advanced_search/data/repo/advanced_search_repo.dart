import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../../../../../core/helper/shared/shared_init.dart';
import '../../../../home/data/models/search_model.dart';
import '../../../../home/data/models/search_query_model.dart';

import '../models/search_filters_model.dart';

class AdvancedSearchApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.jamilhelal.me/api/v1',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<FilterModel> getFilters() async {
    try {
      final response = await dio.get(
        '/search/filters',
        options: Options(
          headers: {'Accept': 'application/xml, application/json'},
        ),
      );
      return _parseFilters(response.data);
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

      throw Exception('Failed to load search filters');
    } on FormatException {
      throw Exception('Invalid search filters response');
    }
  }

  Future<SearchResponseModel> search(SearchBodyModel body) async {
    try {
      final token = await AuthStorage.getAccessToken();
      final response = await dio.post(
        '/ahadith/search',
        data: body.toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data is! Map) {
        throw const FormatException('Unsupported search response');
      }
      return _parseSearchResponse(response.data);
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

      throw Exception('Failed to search hadiths');
    } on FormatException {
      throw Exception('Invalid search response');
    }
  }

  FilterModel _parseFilters(dynamic data) {
    if (data is Map) {
      return FilterModel.fromJson(Map<String, dynamic>.from(data));
    }

    if (data is String) {
      final document = XmlDocument.parse(data);
      return FilterModel.fromJson({
        'books': _parseBooks(document, 'books'),
        'muhaddiths': _parseBooks(document, 'muhaddiths'),
        'rawis': _parseBooks(document, 'rawis'),
        'rulings': _parseBooks(document, 'rulings'),
        'topics': _parseBooks(document, 'topics'),
        'types': _parseTypes(document),
      });
    }

    throw const FormatException('Unsupported search filters response');
  }

  SearchResponseModel _parseSearchResponse(dynamic data) {
    final response = Map<String, dynamic>.from(data as Map);
    final topLevelItems = response['items'];
    if (topLevelItems is List && topLevelItems.isNotEmpty) {
      return SearchResponseModel.fromJson(response);
    }

    for (final key in ['data', 'result', 'payload']) {
      final nested = response[key];
      if (nested is Map && nested['items'] is List) {
        return SearchResponseModel.fromJson(Map<String, dynamic>.from(nested));
      }
      if (nested is List) {
        return SearchResponseModel.fromJson({
          'items': nested,
          'pagination': response['pagination'],
        });
      }
    }

    for (final key in ['results', 'content', 'hadiths']) {
      final items = response[key];
      if (items is List) {
        return SearchResponseModel.fromJson({
          'items': items,
          'pagination': response['pagination'],
        });
      }
    }

    if (topLevelItems is List) {
      return SearchResponseModel.fromJson(response);
    }

    throw const FormatException('Search response does not contain items');
  }

  List<Map<String, String>> _parseBooks(XmlDocument document, String group) {
    return _groupItems(document, group)
        .map(
          (item) => {
            'id': _childText(item, 'id') ?? '',
            'name': _childText(item, 'name') ?? '',
          },
        )
        .toList();
  }

  List<Map<String, String>> _parseTypes(XmlDocument document) {
    return _groupItems(document, 'types')
        .map(
          (item) => {
            'id': _childText(item, 'id') ?? '',
            'label':
                _childText(item, 'label') ?? _childText(item, 'name') ?? '',
          },
        )
        .toList();
  }

  Iterable<XmlElement> _groupItems(XmlDocument document, String group) {
    return document.descendants
        .whereType<XmlElement>()
        .where((element) => element.name.local == group)
        .where((element) => element.getElement('id') != null);
  }

  String? _childText(XmlElement element, String name) {
    return element.getElement(name)?.innerText.trim();
  }
}

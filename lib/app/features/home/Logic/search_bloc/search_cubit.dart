import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/search_model.dart';
import '../../data/models/search_query_model.dart';
import '../../data/repo/search_repo.dart';
import 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit() : super(SearchCubitInitial());

  int _page = 0;
  bool _hasNext = false;
  bool _isLoadingMore = false;
  String? _query;
  final List<Item> _results = [];

  void reset() {
    _page = 0;
    _hasNext = false;
    _isLoadingMore = false;
    _query = null;
    _results.clear();
    emit(SearchCubitInitial());
  }

  Future<void> search(SearchBodyModel query) async {
    _query = query.query;
    _page = 0;
    _hasNext = false;
    _isLoadingMore = false;
    _results.clear();
    emit(SearchCubitLoading());
    try {
      final response = await _fetchPage(_page);
      _results.addAll(response.items ?? []);
      _hasNext = response.pagination?.hasNext ?? false;
      if (!isClosed) emit(SearchCubitSuccess(_withResults(response)));
    } catch (e) {
      if (!isClosed) emit(SearchCubitError('Failed to search: $e'));
    }
  }

  Future<void> loadMore() async {
    if (!_hasNext || _isLoadingMore || _query == null) return;

    _isLoadingMore = true;
    final nextPage = _page + 1;
    try {
      final response = await _fetchPage(nextPage);
      _page = nextPage;
      _hasNext = response.pagination?.hasNext ?? false;
      _results.addAll(response.items ?? []);
      if (!isClosed) emit(SearchCubitSuccess(_withResults(response)));
    } catch (e) {
      if (!isClosed) emit(SearchCubitError('Failed to load more results: $e'));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<SearchResponseModel> _fetchPage(int page) {
    return SearchApiService().getFilters(
      SearchBodyModel(
        query: _query,
        sort: 'RELEVANCE',
        mode: 'FLEXIBLE',
        page: page,
        size: 10,
        includeExplanation: false,
      ),
    );
  }

  SearchResponseModel _withResults(SearchResponseModel response) {
    return SearchResponseModel(
      items: List<Item>.of(_results),
      pagination: response.pagination,
    );
  }
}

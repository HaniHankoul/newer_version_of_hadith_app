import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/home/data/models/search_query_model.dart';
import 'package:hadith_app/app/features/home/data/models/search_model.dart';
import 'package:hadith_app/app/features/search/advanced_search/data/repo/advanced_search_repo.dart';
import '../data/models/search_filters_model.dart';
import 'advanced_search_states.dart';

class AdvancedSearchCubit extends Cubit<AdvancedSearchStates> {
  AdvancedSearchCubit({AdvancedSearchApiService? repository})
    : _repository = repository ?? AdvancedSearchApiService(),
      super(AdvancedSearchInitial());

  final AdvancedSearchApiService _repository;
  FilterModel? filters;
  Map<String, List<String>> selectedFilters = {};
  String _searchMode = 'FLEXIBLE';
  String _query = '';
  int _page = 0;
  bool _hasNext = false;
  final List<Item> results = [];

  String get searchMode => _searchMode;

  void updateSearchMode(String mode) {
    if (mode == 'EXACT' || mode == 'FLEXIBLE') {
      _searchMode = mode;
    }
  }

  void updateSelectedFilters(Map<String, List<String>> values) {
    selectedFilters = {
      for (final entry in values.entries)
        entry.key: List<String>.from(entry.value),
    };
  }

  SearchBodyModel _buildSearchBody({required int page}) {
    return SearchBodyModel(
      query: _query,
      sort: 'RELEVANCE',
      mode: _searchMode,
      page: page,
      size: 10,
      includeExplanation: false,
      bookIds: selectedFilters['bookIds'] ?? const [],
      muhaddithIds: selectedFilters['muhaddithIds'] ?? const [],
      rawiIds: selectedFilters['rawiIds'] ?? const [],
      rulingIds: selectedFilters['rulingIds'] ?? const [],
      topicIds: selectedFilters['topicIds'] ?? const [],
      types: selectedFilters['types'] ?? const [],
    );
  }

  Future<void> loadFilters() async {
    emit(AdvancedSearchLoading());
    try {
      filters = await _repository.getFilters();
      if (!isClosed) emit(AdvancedSearchFiltersLoaded(filters!));
    } catch (e) {
      if (!isClosed) emit(AdvancedSearchError('Failed to load filters: $e'));
    }
  }

  Future<void> search(String query) async {
    _query = query;
    _page = 0;
    _hasNext = false;
    results.clear();
    emit(AdvancedSearchLoading());
    try {
      final response = await _repository.search(_buildSearchBody(page: _page));
      results.addAll(response.items ?? []);
      _hasNext = response.pagination?.hasNext ?? false;
      if (!isClosed) emit(AdvancedSearchSuccess(response));
    } catch (e) {
      if (isClosed) return;
      emit(AdvancedSearchError('Failed to search: $e'));
    }
  }

  Future<void> loadMore() async {
    if (!_hasNext ||
        state is AdvancedSearchLoading ||
        state is AdvancedSearchLoadingMore) {
      return;
    }

    final nextPage = _page + 1;
    emit(AdvancedSearchLoadingMore());
    try {
      final response = await _repository.search(
        _buildSearchBody(page: nextPage),
      );
      _page = nextPage;
      _hasNext = response.pagination?.hasNext ?? false;
      results.addAll(response.items ?? []);
      if (!isClosed) emit(AdvancedSearchSuccess(response));
    } catch (e) {
      if (!isClosed) emit(AdvancedSearchError('Failed to search: $e'));
    }
  }
}

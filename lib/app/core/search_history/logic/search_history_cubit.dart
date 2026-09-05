import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/search_history_repo.dart';
import 'search_history_states.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  SearchHistoryCubit({SearchHistoryRepo? repository})
    : _repository = repository ?? SearchHistoryRepo(),
      super(SearchHistoryInitial());

  final SearchHistoryRepo _repository;

  Future<void> loadHistory({String keyword = ''}) async {
    emit(SearchHistoryLoading());
    try {
      final items = await _repository.getSearchHistory(
        source: 'Hadith',
        keyword: keyword,
        limit: 5,
      );
      if (!isClosed) emit(SearchHistoryLoaded(items));
    } catch (error) {
      if (!isClosed) emit(SearchHistoryError(error.toString()));
    }
  }

  void clear() {
    if (!isClosed) emit(SearchHistoryInitial());
  }

  Future<void> deleteItem(String id) async {
    final currentState = state;
    if (currentState is! SearchHistoryLoaded) return;

    try {
      await _repository.deleteHistoryItem(id);
      if (!isClosed) {
        emit(
          SearchHistoryLoaded(
            currentState.items.where((item) => item.id != id).toList(),
          ),
        );
      }
    } catch (error) {
      if (!isClosed) emit(SearchHistoryError(error.toString()));
    }
  }

  Future<void> clearAll() async {
    try {
      await _repository.clearHistory();
      clear();
    } catch (error) {
      if (!isClosed) emit(SearchHistoryError(error.toString()));
    }
  }
}

import '../data/models/search_history_model.dart';

sealed class SearchHistoryState {}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryLoading extends SearchHistoryState {}

class SearchHistoryLoaded extends SearchHistoryState {
  SearchHistoryLoaded(this.items);

  final List<SearchHistoryModel> items;
}

class SearchHistoryError extends SearchHistoryState {
  SearchHistoryError(this.message);

  final String message;
}

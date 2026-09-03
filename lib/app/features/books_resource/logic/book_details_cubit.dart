import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/book_response.dart';
import '../data/repo/book_repo.dart';
import 'book_details_cubit_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsCubitState> {
  BookDetailsCubit({required this.bookId, BookRepo? repository})
    : _repository = repository ?? BookRepo(),
      super(BookDetailsInitial());

  final String bookId;
  final BookRepo _repository;
  final List<Item> _hadiths = [];
  int _page = 0;
  bool _hasNext = true;

  Future<void> fetchBookHadiths() async {
    _page = 0;
    _hasNext = true;
    _hadiths.clear();
    emit(BookDetailsLoading());
    try {
      final response = await _repository.getBookHadiths(
        bookId: bookId,
        page: _page,
      );
      _setPage(response);
    } catch (e) {
      if (!isClosed) emit(BookDetailsError(_message(e)));
    }
  }

  Future<void> loadMore() async {
    if (!_hasNext ||
        state is BookDetailsLoading ||
        state is BookDetailsLoadingMore) {
      return;
    }

    emit(BookDetailsLoadingMore(List.unmodifiable(_hadiths)));
    try {
      final response = await _repository.getBookHadiths(
        bookId: bookId,
        page: _page + 1,
      );
      _page++;
      _setPage(response);
    } catch (e) {
      if (!isClosed) emit(BookDetailsError(_message(e)));
    }
  }

  void _setPage(BookResponse response) {
    _hadiths.addAll(response.items ?? const []);
    _hasNext = response.pagination?.hasNext ?? false;
    if (!isClosed) {
      emit(
        BookDetailsSuccess(
          List.unmodifiable(_hadiths),
          pagination: response.pagination,
        ),
      );
    }
  }

  String _message(Object error) =>
      error.toString().replaceFirst('Exception: ', '');
}

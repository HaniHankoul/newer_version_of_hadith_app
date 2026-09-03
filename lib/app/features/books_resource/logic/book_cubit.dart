import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/book_repo.dart';
import 'book_cubit_state.dart';

class BookCubit extends Cubit<BookCubitState> {
  BookCubit({BookRepo? repository})
    : _repository = repository ?? BookRepo(),
      super(BookCubitInitial());

  final BookRepo _repository;

  Future<void> fetchBooks() async {
    emit(BookCubitLoading());
    try {
      final books = await _repository.getBooks();
      if (!isClosed) emit(BookCubitSuccess(books));
    } catch (e) {
      if (!isClosed) {
        emit(BookCubitError(e.toString().replaceFirst('Exception: ', '')));
      }
    }
  }
}

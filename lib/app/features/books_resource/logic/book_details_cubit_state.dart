import '../data/models/book_response.dart';

abstract class BookDetailsCubitState {}

class BookDetailsInitial extends BookDetailsCubitState {}

class BookDetailsLoading extends BookDetailsCubitState {}

class BookDetailsLoadingMore extends BookDetailsCubitState {
  final List<Item> hadiths;

  BookDetailsLoadingMore(this.hadiths);
}

class BookDetailsSuccess extends BookDetailsCubitState {
  final List<Item> hadiths;
  final Pagination? pagination;

  BookDetailsSuccess(this.hadiths, {this.pagination});
}

class BookDetailsError extends BookDetailsCubitState {
  final String message;

  BookDetailsError(this.message);
}

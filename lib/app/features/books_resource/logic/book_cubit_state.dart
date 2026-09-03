import '../data/models/book_model.dart';

abstract class BookCubitState {}

class BookCubitInitial extends BookCubitState {}

class BookCubitLoading extends BookCubitState {}

class BookCubitSuccess extends BookCubitState {
  final List<BookModel> books;

  BookCubitSuccess(this.books);
}

class BookCubitError extends BookCubitState {
  final String message;

  BookCubitError(this.message);
}

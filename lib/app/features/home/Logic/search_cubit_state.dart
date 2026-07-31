import '../data/models/search_model.dart';

abstract class SearchCubitState {}

class SearchCubitInitial extends SearchCubitState {}

class SearchCubitLoading extends SearchCubitState {}

class SearchCubitSuccess extends SearchCubitState {
  Searchmodel searchModel;
  SearchCubitSuccess(this.searchModel);
}

class SearchCubitError extends SearchCubitState {
  String errorMessage;
  SearchCubitError(this.errorMessage);
}

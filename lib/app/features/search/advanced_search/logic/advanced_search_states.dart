import '../data/models/search_filters_model.dart';
import '../../../home/data/models/search_model.dart';

abstract class AdvancedSearchStates {}

class AdvancedSearchInitial extends AdvancedSearchStates {}

class AdvancedSearchLoading extends AdvancedSearchStates {}

class AdvancedSearchLoadingMore extends AdvancedSearchStates {}

class AdvancedSearchFiltersLoaded extends AdvancedSearchStates {
  final FilterModel filters;

  AdvancedSearchFiltersLoaded(this.filters);
}

class AdvancedSearchSuccess extends AdvancedSearchStates {
  final SearchResponseModel response;

  AdvancedSearchSuccess(this.response);
}

class AdvancedSearchError extends AdvancedSearchStates {
  String message;
  AdvancedSearchError(this.message);
}

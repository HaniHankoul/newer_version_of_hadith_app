abstract class AdvancedSearchStates {}

class AdvancedSearchInitial extends AdvancedSearchStates {}

class AdvancedSearchLoading extends AdvancedSearchStates {}

class AdvancedSearchSuccess extends AdvancedSearchStates {}

class AdvancedSearchError extends AdvancedSearchStates {
  String message;
  AdvancedSearchError(this.message);
}

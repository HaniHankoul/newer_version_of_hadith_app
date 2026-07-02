import 'package:flutter_bloc/flutter_bloc.dart';

import 'advanced_search_states.dart';

class AdvancedSearchCubit extends Cubit<AdvancedSearchStates> {
  AdvancedSearchCubit() : super(AdvancedSearchInitial());

  void search(String query) async {
    emit(AdvancedSearchLoading());
    try {
      // Simulate a search operation
      await Future.delayed(Duration(seconds: 2));
      // If the search is successful, emit the success state
      emit(AdvancedSearchSuccess());
    } catch (e) {
      // If an error occurs, emit the error state
      emit(AdvancedSearchError('Failed to search: $e'));
    }
  }
}

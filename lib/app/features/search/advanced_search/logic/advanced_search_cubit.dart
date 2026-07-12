import 'package:flutter_bloc/flutter_bloc.dart';
import 'advanced_search_states.dart';

class AdvancedSearchCubit extends Cubit<AdvancedSearchStates> {
  AdvancedSearchCubit() : super(AdvancedSearchInitial());

  void search(String query) async {
    emit(AdvancedSearchLoading());
    try {
      await Future.delayed(Duration(seconds: 2));
      if (isClosed) return;
      emit(AdvancedSearchSuccess());
    } catch (e) {
      emit(AdvancedSearchError('Failed to search: $e'));
    }
  }
}

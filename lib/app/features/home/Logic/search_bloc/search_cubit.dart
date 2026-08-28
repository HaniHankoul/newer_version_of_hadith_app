import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/search_query_model.dart';
import '../../data/repo/search_repo.dart';
import 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit() : super(SearchCubitInitial());

  void search(SearchBodyModel query) async {
    emit(SearchCubitLoading());
    try {
      final response = await SearchApiService().getFilters(
        SearchBodyModel(
          query: query.query,
          sort: 'RELEVANCE',
          mode: 'EXACT',
          page: 1,
          size: 10,
          includeExplanation: false,
        ),
      );
      emit(SearchCubitSuccess(response));
    } catch (e) {
      emit(SearchCubitError('Failed to search: $e'));
    }
  }
}

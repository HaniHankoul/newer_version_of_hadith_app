import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/search_repo.dart';
import 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit() : super(SearchCubitInitial());

  void search() async {
    emit(SearchCubitLoading());
    try {
      final response = await SearchApiService().search();
      print('sdfsdfsdasfffsfsfsfdjgsdjgsjg');
      emit(SearchCubitSuccess(response));
    } catch (e) {
      emit(SearchCubitError('Failed to search: $e'));
    }
  }
}

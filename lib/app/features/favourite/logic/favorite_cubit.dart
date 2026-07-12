import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorit_cubit_states.dart';

class FavoriteCubit extends Cubit<FavoritCubitStates> {
  FavoriteCubit() : super(FavoriteCubitInitial());
  void showFavorite() async {
    emit(FavoriteCubitLoading());
    try {
      await Future.delayed(Duration(seconds: 2));
      if (isClosed) return;
      emit(FavoriteCubitSuccess());
    } catch (e) {
      emit(FavoriteCubitError('Failed to search: $e'));
    }
  }
}

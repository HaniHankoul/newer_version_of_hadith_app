import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/favorite_repo.dart';
import 'favorit_cubit_states.dart';

class FavoriteCubit extends Cubit<FavoritCubitStates> {
  FavoriteCubit({FavoriteRepo? repository})
    : _repository = repository ?? FavoriteRepo(),
      super(FavoriteCubitInitial());

  final FavoriteRepo _repository;

  Future<void> showFavorite() async {
    emit(FavoriteCubitLoading());
    try {
      final favorites = await _repository.getFavorites();
      if (isClosed) return;
      emit(FavoriteCubitSuccess(favorites));
    } catch (e) {
      if (isClosed) return;
      emit(FavoriteCubitError('Failed to search: $e'));
    }
  }

  Future<void> addFavorite(String hadithId) async {
    emit(FavoriteCubitAdding());
    try {
      final added = await _repository.addFavorite(hadithId);
      if (isClosed) return;
      emit(FavoriteCubitAddSuccess(added));
    } catch (e) {
      if (isClosed) return;
      emit(FavoriteCubitError('Failed to add favorite: $e'));
    }
  }

  Future<void> removeFavorite(String hadithId) async {
    emit(FavoriteCubitAdding());
    try {
      await _repository.removeFavorite(hadithId);
      if (isClosed) return;
      emit(FavoriteCubitRemoveSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(FavoriteCubitError('Failed to remove favorite: $e'));
    }
  }
}

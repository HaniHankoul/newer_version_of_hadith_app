import '../data/models/favorite_model.dart';

class FavoritCubitStates {}

class FavoriteCubitInitial extends FavoritCubitStates {}

class FavoriteCubitLoading extends FavoritCubitStates {}

class FavoriteCubitAdding extends FavoritCubitStates {}

class FavoriteCubitAddSuccess extends FavoritCubitStates {
  final bool added;

  FavoriteCubitAddSuccess(this.added);
}

class FavoriteCubitRemoveSuccess extends FavoritCubitStates {}

class FavoriteCubitSuccess extends FavoritCubitStates {
  FavoriteModel favoritModel;
  FavoriteCubitSuccess(this.favoritModel);
}

class FavoriteCubitError extends FavoritCubitStates {
  final String error;
  FavoriteCubitError(this.error);
}

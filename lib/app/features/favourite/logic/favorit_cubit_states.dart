class FavoritCubitStates {}

class FavoriteCubitInitial extends FavoritCubitStates {}

class FavoriteCubitLoading extends FavoritCubitStates {}

class FavoriteCubitSuccess extends FavoritCubitStates {}

class FavoriteCubitError extends FavoritCubitStates {
  String error;
  FavoriteCubitError(this.error);
}

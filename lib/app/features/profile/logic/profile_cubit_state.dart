abstract class ProfileCubitState {}

class ProfileCubitInitial extends ProfileCubitState {}

class ProfileCubitLoading extends ProfileCubitState {}

class ProfileCubitSuccess extends ProfileCubitState {}

class ProfileCubitError extends ProfileCubitState {
  final String errorMessage;
  ProfileCubitError(this.errorMessage);
}

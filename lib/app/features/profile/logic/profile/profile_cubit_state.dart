import '../../data/models/profile_response_model.dart';

abstract class ProfileCubitState {}

class ProfileCubitInitial extends ProfileCubitState {}

class ProfileCubitLoading extends ProfileCubitState {}

class ProfileCubitSuccess extends ProfileCubitState {
  final ProfileResponse? profileResponse;
  ProfileCubitSuccess({this.profileResponse});
}

class ProfileCubitError extends ProfileCubitState {
  final String errorMessage;
  ProfileCubitError(this.errorMessage);
}

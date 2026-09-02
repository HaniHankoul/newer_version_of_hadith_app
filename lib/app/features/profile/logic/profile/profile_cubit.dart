import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/profile_repo.dart';
import 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  final ProfileRepo repository;

  ProfileCubit({ProfileRepo? repository})
    : repository = repository ?? ProfileRepo(),
      super(ProfileCubitInitial());
  void loadProfile() async {
    emit(ProfileCubitLoading());
    try {
      final response = await repository.getProfile();
      if (isClosed) return;
      emit(ProfileCubitSuccess(profileResponse: response));
    } catch (e) {
      if (isClosed) return;
      emit(ProfileCubitError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String gender,
    required String birthDate,
  }) async {
    final currentProfile = state is ProfileCubitSuccess
        ? (state as ProfileCubitSuccess).profileResponse
        : state is ProfileCubitUpdating
        ? (state as ProfileCubitUpdating).profileResponse
        : null;
    if (currentProfile == null) return;

    emit(ProfileCubitUpdating(currentProfile));
    try {
      final response = await repository.updateProfile(
        name: name,
        gender: gender,
        birthDate: birthDate,
      );
      if (!isClosed) emit(ProfileCubitSuccess(profileResponse: response));
    } catch (e) {
      if (!isClosed) emit(ProfileCubitError(e.toString()));
    }
  }
}

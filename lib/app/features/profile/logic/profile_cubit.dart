import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/profile_repo.dart';
import 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit() : super(ProfileCubitInitial());
  void updateProfile() async {
    emit(ProfileCubitLoading());
    try {
      final response = await ProfileRepo().getProfile();
      if (isClosed) return;
      emit(ProfileCubitSuccess(profileResponse: response));
    } catch (e) {
      if (isClosed) return;
      emit(ProfileCubitError(e.toString()));
    }
  }
}

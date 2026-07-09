import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit() : super(ProfileCubitInitial());
  void updateProfile() async {
    emit(ProfileCubitLoading());
    try {
      // Simulate a delay for the update operation
      await Future.delayed(Duration(seconds: 2));
      if (isClosed) return;
      emit(ProfileCubitSuccess());
    } catch (e) {
      emit(ProfileCubitError(e.toString()));
    }
  }
}

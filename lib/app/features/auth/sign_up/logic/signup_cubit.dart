import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/signup_model.dart';
import '../data/repo/signup_repo.dart';
import 'signup_states.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  void signup(Signupmodel model) async {
    emit(SignupLoadingState());
    try {
      final signup = await SignupApiService().signup(
        Signupmodel(
          name: model.name,
          email: model.email,
          password: model.password,
          gender: model.gender,
          birthDate: model.birthDate,
        ),
      );
      emit(SignupSuccessState(signup));
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/auth/login/data/repo/login_repo.dart';

import '../data/models/login_model.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  void login(Loginmodel model) async {
    emit(LoginLoading());
    try {
      final login = await LoginApiService().login(
        Loginmodel(email: model.email, password: model.password),
      );
      emit(LoginSuccess(login));
      print("success ${login.user.email} ${login.user.name} ${login.user.id}");
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

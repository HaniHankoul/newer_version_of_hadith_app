import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/shared/shared_init.dart';
import '../data/models/login_model.dart';
import '../data/models/login_model_res.dart';
import '../data/repo/login_repo.dart';
import 'login_states.dart';

Loginmodelresponse? loginResponseGlobal;

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  void login(Loginmodel model) async {
    emit(LoginLoading());
    try {
      final login = await LoginApiService().login(
        Loginmodel(email: model.email, password: model.password),
      );
      loginResponseGlobal = login;
      await AuthStorage.saveTokens(
        accessToken: login.accessToken,
        refreshToken: login.refreshToken,
        tokenType: login.tokenType,
      );
      emit(LoginSuccess(login));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

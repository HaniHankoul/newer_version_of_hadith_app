import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/shared/shared_init.dart';
import '../../../../core/notifications/fcm_service.dart';
import '../data/models/login_model.dart';
import '../data/models/login_model_res.dart';
import '../data/repo/login_repo.dart';
import 'login_states.dart';
import 'services/services.dart';

Loginmodelresponse? loginResponseGlobal;

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());

    try {
      final idToken =
          await GoogleLoginService.instance.signIn();

      final login =
          await LoginApiService().googleLogin(idToken);

      loginResponseGlobal = login;

      await AuthStorage.saveTokens(
        accessToken: login.accessToken,
        refreshToken: login.refreshToken,
        tokenType: login.tokenType,
      );

      await FcmService.syncCurrentToken();

      emit(LoginSuccess(login));
    } catch (e) {
      final error = e.toString();

      emit(
        LoginError(
          error.startsWith('Exception: ')
              ? error.substring('Exception: '.length)
              : error,
        ),
      );
    }
  }

  Future<void> login(Loginmodel model) async {
    emit(LoginLoading());

    try {
      final login = await LoginApiService().login(
        Loginmodel(
          email: model.email,
          password: model.password,
        ),
      );

      loginResponseGlobal = login;

      await AuthStorage.saveTokens(
        accessToken: login.accessToken,
        refreshToken: login.refreshToken,
        tokenType: login.tokenType,
      );

      await FcmService.syncCurrentToken();

      emit(LoginSuccess(login));
    } catch (e) {
      final error = e.toString();

      emit(
        LoginError(
          error.startsWith('Exception: ')
              ? error.substring('Exception: '.length)
              : error,
        ),
      );
    }
  }
}
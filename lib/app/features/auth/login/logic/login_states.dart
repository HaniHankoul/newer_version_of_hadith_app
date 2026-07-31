import 'package:hadith_app/app/features/auth/login/data/models/login_model_res.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final Loginmodelresponse loginResponse;
  LoginSuccess(this.loginResponse);
}

class LoginError extends LoginStates {
  final String error;
  LoginError(this.error);
}

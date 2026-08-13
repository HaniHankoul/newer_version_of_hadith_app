import '../data/models/signup_model_res.dart';

abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final Signupmodelresponse signupResponse;
  SignupSuccessState(this.signupResponse);
}

class SignupErrorState extends SignupState {
  final String errorMessage;
  SignupErrorState(this.errorMessage);
}

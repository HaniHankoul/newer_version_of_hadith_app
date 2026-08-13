abstract class AccessState {}

class AccessInitial extends AccessState {}

class AccessLoading extends AccessState {}

class AccessSuccess extends AccessState {
  final String? token;
  AccessSuccess(this.token);
}

class AccessError extends AccessState {
  final String errorMessage;
  AccessError(this.errorMessage);
}

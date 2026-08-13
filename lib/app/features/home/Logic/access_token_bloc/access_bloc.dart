import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/helper/shared/shared_init.dart';

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

class AccessBloc extends Cubit<AccessState> {
  AccessBloc() : super(AccessInitial());

  void getAccessToken() async {
    emit(AccessLoading());
    try {
      final response = await AuthStorage.getAccessToken();
      emit(AccessSuccess(response));
    } catch (e) {
      emit(AccessError('Failed to get access token: $e'));
    }
  }
}

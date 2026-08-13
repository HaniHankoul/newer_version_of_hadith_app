import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/helper/shared/shared_init.dart';

import 'acces_states.dart';

class AccessBloc extends Cubit<AccessState> {
  AccessBloc() : super(AccessInitial());

  void getAccessToken() async {
    emit(AccessLoading());
    try {
      final response = await AuthStorage.getAccessToken();
      emit(AccessSuccess(response));
      print('AccessBloc: access token loaded successfully:');
    } catch (e) {
      emit(AccessError('Failed to get access token: $e'));
    }
  }
}

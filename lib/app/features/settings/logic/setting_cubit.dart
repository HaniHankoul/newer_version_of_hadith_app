import 'package:flutter_bloc/flutter_bloc.dart';

import 'setting_states.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  void updateSetting() async {
    emit(SettingLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      if (isClosed) return;
      emit(SettingSuccess());
    } catch (e) {
      emit(SettingError('Failed to update setting: $e'));
    }
  }
}

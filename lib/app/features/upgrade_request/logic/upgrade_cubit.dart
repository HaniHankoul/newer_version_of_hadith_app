import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/upgrade_request/logic/upgrade_state.dart';

class UpgradeCubit extends Cubit<UpgradeState> {
  UpgradeCubit() : super(UpgradeInitial());

  Future<void> upgrade() async {
    emit(UpgradeLoading());
    try {
      // Simulate an upgrade request
      await Future.delayed(const Duration(seconds: 2));
      emit(UpgradeSuccess());
    } catch (e) {
      emit(UpgradeFailure(e.toString()));
    }
  }
}

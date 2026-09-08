import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/upgrade_request/logic/upgrade_current_states.dart';

import '../data/repo/upgrade_repo.dart';

class UpgradeCurrentCubit extends Cubit<UpgradeCurrentStates> {
  final UpgradeRepo repository;

  UpgradeCurrentCubit({UpgradeRepo? repository})
    : repository = repository ?? UpgradeRepo(),
      super(UpgradeCurrentInitial());

  Future<void> loadCurrentRequest() async {
    emit(UpgradeCurrentLoading());
    try {
      final res = await repository.getCurrentUpgradeRequests();
      emit(UpgradeCurrentLoaded(request: res));
    } catch (e) {
      if (!isClosed) emit(UpgradeCurrentFailure(_cleanError(e)));
    }
  }

  String _cleanError(Object error) =>
      error.toString().replaceFirst('Exception: ', '');
}

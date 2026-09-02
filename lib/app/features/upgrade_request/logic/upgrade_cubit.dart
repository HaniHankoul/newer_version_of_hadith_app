import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/upgrade_model_response.dart';
import '../data/repo/upgrade_repo.dart';
import 'package:hadith_app/app/features/upgrade_request/logic/upgrade_state.dart';

class UpgradeCubit extends Cubit<UpgradeState> {
  final UpgradeRepo repository;

  UpgradeCubit({UpgradeRepo? repository})
    : repository = repository ?? UpgradeRepo(),
      super(UpgradeInitial());

  Future<void> loadRequests() async {
    emit(UpgradeLoading());
    try {
      emit(UpgradeLoaded(await repository.getUpgradeRequests()));
    } catch (e) {
      if (!isClosed) emit(UpgradeFailure(_cleanError(e)));
    }
  }

  Future<void> submit({
    required String filePath,
    required String fileName,
    required String notes,
  }) async {
    final currentRequests = state is UpgradeLoaded
        ? (state as UpgradeLoaded).requests
        : state is UpgradeSubmitting
        ? (state as UpgradeSubmitting).requests
        : <UpgradeModelResponse>[];
    emit(UpgradeSubmitting(currentRequests));
    try {
      final request = await repository.submitUpgradeRequest(
        filePath: filePath,
        fileName: fileName,
        notes: notes,
      );
      final requests = await repository.getUpgradeRequests();
      if (!isClosed) emit(UpgradeSubmitSuccess(requests, request));
    } catch (e) {
      if (!isClosed) emit(UpgradeFailure(_cleanError(e), currentRequests));
    }
  }

  String _cleanError(Object error) =>
      error.toString().replaceFirst('Exception: ', '');
}

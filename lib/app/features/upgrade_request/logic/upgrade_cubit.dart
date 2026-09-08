import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/upgrade_model_response.dart';
import '../data/repo/upgrade_repo.dart';
import 'upgrade_state.dart';

class UpgradeCubit extends Cubit<UpgradeState> {
  final UpgradeRepo repository;

  UpgradeCubit({UpgradeRepo? repository})
    : repository = repository ?? UpgradeRepo(),
      super(UpgradeInitial());

  Future<void> loadRequest() async {
    emit(UpgradeLoading());

    try {
      final request = await repository.getUpgradeRequest();

      if (!isClosed) {
        emit(UpgradeLoaded(request));
      }
    } catch (e) {
      if (!isClosed) {
        emit(UpgradeFailure(_cleanError(e)));
      }
    }
  }

  Future<void> submit({
    required String filePath,
    required String fileName,
    required String notes,
  }) async {
    UpgradeModelResponse? currentRequest;

    if (state is UpgradeLoaded) {
      currentRequest = (state as UpgradeLoaded).request;
    } else if (state is UpgradeSubmitting) {
      currentRequest = (state as UpgradeSubmitting).request;
    } else if (state is UpgradeFailure) {
      currentRequest = (state as UpgradeFailure).request;
    }

    emit(UpgradeSubmitting(currentRequest));

    try {
      final request = await repository.submitUpgradeRequest(
        filePath: filePath,
        fileName: fileName,
        notes: notes,
      );

      if (!isClosed) {
        emit(UpgradeSubmitSuccess(request));
      }
    } catch (e) {
      if (!isClosed) {
        emit(UpgradeFailure(_cleanError(e), currentRequest));
      }
    }
  }

  String _cleanError(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}

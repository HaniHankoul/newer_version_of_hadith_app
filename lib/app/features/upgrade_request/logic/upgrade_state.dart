import '../data/models/upgrade_model_response.dart';

abstract class UpgradeState {}

class UpgradeInitial extends UpgradeState {}

class UpgradeLoading extends UpgradeState {}

class UpgradeLoaded extends UpgradeState {
  final UpgradeModelResponse? request;

  UpgradeLoaded(this.request);
}

class UpgradeSubmitting extends UpgradeState {
  final UpgradeModelResponse? request;

  UpgradeSubmitting(this.request);
}

class UpgradeSubmitSuccess extends UpgradeState {
  final UpgradeModelResponse request;

  UpgradeSubmitSuccess(this.request);
}

class UpgradeFailure extends UpgradeState {
  final String errorMessage;
  final UpgradeModelResponse? request;

  UpgradeFailure(this.errorMessage, [this.request]);
}

import '../data/models/upgrade_model_response.dart';

abstract class UpgradeState {}

class UpgradeInitial extends UpgradeState {}

class UpgradeLoading extends UpgradeState {}

class UpgradeLoaded extends UpgradeState {
  final List<UpgradeModelResponse> requests;

  UpgradeLoaded(this.requests);
}

class UpgradeSubmitting extends UpgradeState {
  final List<UpgradeModelResponse> requests;

  UpgradeSubmitting(this.requests);
}

class UpgradeSubmitSuccess extends UpgradeLoaded {
  final UpgradeModelResponse request;

  UpgradeSubmitSuccess(super.requests, this.request);
}

class UpgradeFailure extends UpgradeState {
  final String errorMessage;
  final List<UpgradeModelResponse> requests;

  UpgradeFailure(this.errorMessage, [this.requests = const []]);
}

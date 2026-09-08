import '../data/models/upgrade_model_response.dart';

abstract class UpgradeCurrentStates {}

class UpgradeCurrentInitial extends UpgradeCurrentStates {}

class UpgradeCurrentLoading extends UpgradeCurrentStates {}

class UpgradeCurrentLoaded extends UpgradeCurrentStates {
  final UpgradeModelResponse request;

  UpgradeCurrentLoaded({required this.request});
}

class UpgradeCurrentFailure extends UpgradeCurrentStates {
  final String errorMessage;

  UpgradeCurrentFailure(this.errorMessage);
}

abstract class UpgradeState {}

class UpgradeInitial extends UpgradeState {}

class UpgradeLoading extends UpgradeState {}

class UpgradeSuccess extends UpgradeState {}

class UpgradeFailure extends UpgradeState {
  final String errorMessage;

  UpgradeFailure(this.errorMessage);
}

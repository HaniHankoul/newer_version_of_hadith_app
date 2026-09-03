import '../data/model/rawi_model.dart';

abstract class RawiState {}

class RawiInitial extends RawiState {}

class RawiLoading extends RawiState {}

class RawiSuccess extends RawiState {
  final List<RawiModel> rawis;

  RawiSuccess(this.rawis);
}

class RawiError extends RawiState {
  final String message;

  RawiError(this.message);
}

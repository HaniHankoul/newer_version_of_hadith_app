import '../data/model/muhaddith_model.dart';

abstract class MuhaddithState {}

class MuhaddithInitial extends MuhaddithState {}

class MuhaddithLoading extends MuhaddithState {}

class MuhaddithSuccess extends MuhaddithState {
  final List<MuhaddithModel> muhaddiths;

  MuhaddithSuccess(this.muhaddiths);
}

class MuhaddithError extends MuhaddithState {
  final String message;

  MuhaddithError(this.message);
}

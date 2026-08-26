import '../../data/models/avatar_model.dart';

abstract class AvatarState {}

class AvatarInitial extends AvatarState {}

class AvatarLoading extends AvatarState {}

class AvatarSuccess extends AvatarState {
  final Avatarmodel model;
  AvatarSuccess({required this.model});
}

class AvatarDeleted extends AvatarState {}

class AvatarError extends AvatarState {
  final String errorMessage;
  AvatarError(this.errorMessage);
}

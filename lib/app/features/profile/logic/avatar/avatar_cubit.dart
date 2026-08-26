import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repo/avatar_repo.dart';
import 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  AvatarCubit({AvatarRepo? avatarRepo})
    : _avatarRepo = avatarRepo ?? AvatarRepo(),
      super(AvatarInitial());

  final AvatarRepo _avatarRepo;

  Future<void> updateAvatar(XFile image) async {
    emit(AvatarLoading());
    try {
      final model = await _avatarRepo.uploadAvatar(image);
      if (isClosed) return;
      emit(AvatarSuccess(model: model));
    } catch (e) {
      if (isClosed) return;
      emit(AvatarError(e.toString()));
    }
  }

  Future<void> deleteAvatar() async {
    emit(AvatarLoading());
    try {
      await _avatarRepo.deleteAvatar();
      if (isClosed) return;
      emit(AvatarDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(AvatarError(e.toString()));
    }
  }
}

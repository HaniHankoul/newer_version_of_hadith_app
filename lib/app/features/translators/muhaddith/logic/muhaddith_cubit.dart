import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/muhaddith_repo.dart';
import 'muhaddith_state.dart';

class MuhaddithCubit extends Cubit<MuhaddithState> {
  MuhaddithCubit({MuhaddithRepo? repository})
    : _repository = repository ?? MuhaddithRepo(),
      super(MuhaddithInitial());

  final MuhaddithRepo _repository;

  Future<void> fetchMuhaddiths() async {
    emit(MuhaddithLoading());
    try {
      final muhaddiths = await _repository.getMuhaddiths();
      if (!isClosed) emit(MuhaddithSuccess(muhaddiths));
    } catch (e) {
      if (!isClosed) {
        emit(MuhaddithError(e.toString().replaceFirst('Exception: ', '')));
      }
    }
  }
}

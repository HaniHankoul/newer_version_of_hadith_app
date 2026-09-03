import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/rawi_repo.dart';
import 'rawi_state.dart';

class RawiCubit extends Cubit<RawiState> {
  RawiCubit({RawiRepo? repository})
    : _repository = repository ?? RawiRepo(),
      super(RawiInitial());

  final RawiRepo _repository;

  Future<void> fetchRawis() async {
    emit(RawiLoading());
    try {
      final rawis = await _repository.getRawis();
      if (!isClosed) emit(RawiSuccess(rawis));
    } catch (e) {
      if (!isClosed) {
        emit(RawiError(e.toString().replaceFirst('Exception: ', '')));
      }
    }
  }
}

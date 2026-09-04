import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/hadith_detail_repo.dart';
import 'hadith_detail_cubit_state.dart';

class HadithDetailCubit extends Cubit<HadithDetailCubitState> {
  HadithDetailCubit({required this.hadithId, HadithDetailRepo? repository})
    : _repository = repository ?? HadithDetailRepo(),
      super(HadithDetailInitial());

  final String hadithId;
  final HadithDetailRepo _repository;

  Future<void> fetchHadithDetail() async {
    emit(HadithDetailLoading());
    try {
      final hadith = await _repository.getHadithDetail(hadithId);
      if (!isClosed) emit(HadithDetailSuccess(hadith));
    } catch (error) {
      if (!isClosed) {
        emit(
          HadithDetailError(error.toString().replaceFirst('Exception: ', '')),
        );
      }
    }
  }
}

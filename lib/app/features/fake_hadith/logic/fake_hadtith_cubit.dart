import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/fake_hadith_response.dart';
import '../data/repo/fake_hadith_repo.dart';
import 'fake_hadith_state.dart';

class FakeHadtithCubit extends Cubit<FakeHadithState> {
  FakeHadtithCubit({FakeHadithRepo? repository, this.pageSize = 20})
    : _repository = repository ?? FakeHadithRepo(),
      super(FakeHadithInitialState());

  final FakeHadithRepo _repository;
  final int pageSize;
  final List<FakeHadithResponse> _hadiths = [];
  int _page = 0;
  bool _hasNext = false;
  String _query = '';

  Future<void> loadFakeHadith() async {
    _query = '';
    _page = 0;
    _hadiths.clear();
    emit(FakeHadithLoadingState());
    try {
      final response = await _repository.getFakeHadith(
        page: _page,
        size: pageSize,
      );
      _setResults(response);
    } catch (e) {
      if (!isClosed) emit(FakeHadithErrorState(e.toString()));
    }
  }

  Future<void> searchFakeHadith(String query) async {
    _query = query.trim();
    _page = 0;
    _hadiths.clear();
    emit(FakeHadithLoadingState());
    try {
      final response = await _repository.searchFakeHadith(
        query: _query,
        page: _page,
        size: pageSize,
      );
      _setResults(response);
    } catch (e) {
      if (!isClosed) emit(FakeHadithErrorState(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (!_hasNext ||
        state is FakeHadithLoadingState ||
        state is FakeHadithLoadingMoreState) {
      return;
    }

    emit(FakeHadithLoadingMoreState(List.unmodifiable(_hadiths)));
    try {
      final nextPage = _page + 1;
      final response = _query.isEmpty
          ? await _repository.getFakeHadith(page: nextPage, size: pageSize)
          : await _repository.searchFakeHadith(
              query: _query,
              page: nextPage,
              size: pageSize,
            );
      _page = nextPage;
      _setResults(response);
    } catch (e) {
      if (!isClosed) emit(FakeHadithErrorState(e.toString()));
    }
  }

  void _setResults(FakeHadithPage response) {
    _hadiths.addAll(response.items);
    _hasNext = response.pagination?.hasNext ?? false;
    if (!isClosed) {
      emit(
        FakeHadithSuccessState(List.unmodifiable(_hadiths), hasNext: _hasNext),
      );
    }
  }
}

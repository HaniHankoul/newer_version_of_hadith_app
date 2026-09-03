import '../data/model/fake_hadith_response.dart';

abstract class FakeHadithState {}

class FakeHadithInitialState extends FakeHadithState {}

class FakeHadithLoadingState extends FakeHadithState {}

class FakeHadithLoadingMoreState extends FakeHadithState {
  final List<FakeHadithResponse> hadiths;

  FakeHadithLoadingMoreState(this.hadiths);
}

class FakeHadithSuccessState extends FakeHadithState {
  final List<FakeHadithResponse> hadiths;
  final bool hasNext;

  FakeHadithSuccessState(this.hadiths, {required this.hasNext});
}

class FakeHadithErrorState extends FakeHadithState {
  final String errorMessage;

  FakeHadithErrorState(this.errorMessage);
}

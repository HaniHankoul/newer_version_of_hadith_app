import '../../../core/models/hadith_detail_model.dart';

abstract class HadithDetailCubitState {}

class HadithDetailInitial extends HadithDetailCubitState {}

class HadithDetailLoading extends HadithDetailCubitState {}

class HadithDetailSuccess extends HadithDetailCubitState {
  HadithDetailSuccess(this.hadith);

  final HadithDetailModel hadith;
}

class HadithDetailError extends HadithDetailCubitState {
  HadithDetailError(this.message);

  final String message;
}

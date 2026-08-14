import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/questions_repo.dart';
import 'questions_states.dart';

class QuestionsCubit extends Cubit<QuestionsStates> {
  QuestionsCubit() : super(QuestionsInitialState());
  void getQuestions() async {
    emit(QuestionsLoadingState());
    try {
      final response = await QuestionsRepo().getQuestions();
      if (isClosed) return;
      emit(QuestionsSuccessState(response));
      print('QuestionsCubit: Questions fetched successfully: } questions');
    } catch (e) {
      if (isClosed) return;
      emit(QuestionsErrorState(e.toString()));
    }
  }
}

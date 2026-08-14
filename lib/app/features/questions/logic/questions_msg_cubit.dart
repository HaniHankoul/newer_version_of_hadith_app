import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/questions/logic/questions_states.dart';

import '../data/repo/questions_repo.dart';

class QuestionsMsgCubit extends Cubit<QuestionsMessageStates> {
  QuestionsMsgCubit() : super(QuestionsMessageInitialState());

  void sendMessage(String query) async {
    emit(QuestionsMessageLoadingState());
    try {
      final response = await QuestionsRepo().sendMessage(query);
      if (isClosed) return;
      emit(QuestionsMessageSuccessState(response));
    } catch (e) {
      if (isClosed) return;
      emit(QuestionsMessageErrorState(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/questions/logic/questions_states.dart';

import '../data/repo/questions_repo.dart';
import 'questions_cubit.dart';

class QuestionsMsgCubit extends Cubit<QuestionsMessageStates> {
  QuestionsMsgCubit() : super(QuestionsMessageInitialState());

  void sendMessage(BuildContext context, String query) async {
    emit(QuestionsMessageLoadingState());
    try {
      final response = await QuestionsRepo().sendMessage(query);
      // ignore: use_build_context_synchronously
      context.read<QuestionsCubit>().getQuestions();
      if (isClosed) return;
      emit(QuestionsMessageSuccessState(response));
    } catch (e) {
      if (isClosed) return;
      emit(QuestionsMessageErrorState(e.toString()));
    }
  }
}

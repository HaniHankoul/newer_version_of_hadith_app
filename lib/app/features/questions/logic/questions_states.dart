import '../data/models/questions_model_response.dart';

abstract class QuestionsStates {}

class QuestionsInitialState extends QuestionsStates {}

class QuestionsLoadingState extends QuestionsStates {}

class QuestionsSuccessState extends QuestionsStates {
  final QuestionModelResponse questions;
  QuestionsSuccessState(this.questions);
}

class QuestionsErrorState extends QuestionsStates {
  final String errorMessage;
  QuestionsErrorState(this.errorMessage);
}

abstract class QuestionsMessageStates {}

class QuestionsMessageInitialState extends QuestionsMessageStates {}

class QuestionsMessageLoadingState extends QuestionsMessageStates {}

class QuestionsMessageSuccessState extends QuestionsMessageStates {
  final QuestionModelResponse questions;
  QuestionsMessageSuccessState(this.questions);
}

class QuestionsMessageErrorState extends QuestionsMessageStates {
  final String errorMessage;
  QuestionsMessageErrorState(this.errorMessage);
}

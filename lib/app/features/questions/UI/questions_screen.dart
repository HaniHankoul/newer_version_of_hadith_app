import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/error_card.dart';
import '../../../core/widgets/loading_card.dart';
import '../logic/questions_cubit.dart';
import '../logic/questions_states.dart';
import 'widgets/question_card.dart';
import 'widgets/question_header_section.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsStates>(
      builder: (context, state) {
        if (state is QuestionsLoadingState) {
          return LoadingCard();
        } else if (state is QuestionsErrorState) {
          return ErrorCard(message: state.errorMessage);
        } else if (state is QuestionsSuccessState) {
          return Column(
            children: [
              verticalLargeSpacing(),
              QuestionHeaderSection(state: state.questions),
              verticalSmallSpacing(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: state.questions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children:
                          [
                                verticalSmallSpacing(),
                                QuestionCard(
                                  question: state.questions[index],
                                  index: index,
                                ),
                              ]
                              .animate(interval: 100.ms)
                              .fade(duration: 250.ms)
                              .slide(begin: Offset(0, 0.3), duration: 200.ms),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return CustomText(text: 'text');
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import 'package:hadith_app/app/features/questions/UI/widgets/question_header_section.dart';
import 'package:hadith_app/app/features/questions/logic/questions_cubit.dart';
import 'package:hadith_app/app/features/questions/logic/questions_states.dart';
import 'widgets/dialog_body.dart';
import 'widgets/question_card.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsStates>(
      builder: (context, state) {
        if (state is QuestionsLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is QuestionsErrorState) {
          return Center(child: Text('Error: ${state.errorMessage}'));
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
              UniversalButton(
                widthPortion: 0.65,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => QuestionsCubit(),
                      child: DialogBody(),
                    ),
                  );
                },
                title: 'اطرح سؤالك هنا',
                color: AppColors.primaryRich,
                textColor: Colors.black,
                borderColor: AppColors.primaryRich,
                icon: Icons.view_list_outlined,
              ),
            ],
          );
        }
        return CustomText(text: 'text');
      },
    );
  }
}

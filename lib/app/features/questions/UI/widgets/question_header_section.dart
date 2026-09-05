import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';
import 'package:hadith_app/app/features/questions/data/models/questions_model_response.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../../logic/questions_cubit.dart';
import 'dialog_body.dart';

class QuestionHeaderSection extends StatelessWidget {
  const QuestionHeaderSection({super.key, required this.state});
  final List<QuestionModelResponse> state;
  @override
  Widget build(BuildContext context) {
    return UniversalContainer(
      borderColor: Colors.white,
      heightPortion: 0,
      widthPortion: .9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GeneralSizes.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: GeneralSizes.medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UniversalButton(
                    widthPortion: 0.3,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<QuestionsCubit>(),
                          child: DialogBody(),
                        ),
                      );
                    },
                    title: 'اطرح سؤالك ',
                    color: AppColors.primaryRich,
                    textColor: Colors.black,
                    borderColor: AppColors.primaryRich,
                  ),
                  Spacer(),
                  CustomText(text: ' الاسئلة', fontWeight: FontWeight.w700),
                  horizontalMediumSpacing(),
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 23,
                    child: Icon(Icons.question_answer, color: Colors.white),
                  ),
                ],
              ),
            ),
            CustomText(text: 'ملخص لاحصائيات الاسئلة لديك', fontSize: 15),
            verticalLargeSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UniversalContainer(
                  borderR: 10,
                  borderColor: AppColors.primary,
                  heightPortion: 0,
                  widthPortion: .35,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: GeneralSizes.small),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'عدد الاجابات',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            horizontalSmallSpacing(),
                            Icon(Icons.check_box_outlined),
                          ],
                        ),
                      ),
                      CustomText(
                        text: state
                            .where((question) => question.answerText != null)
                            .length
                            .toString(),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ],
                  ),
                ),
                horizontalLargeSpacing(),
                UniversalContainer(
                  borderR: 10,
                  color: AppColors.primary,
                  borderColor: AppColors.primary,
                  heightPortion: 0,
                  widthPortion: .35,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: GeneralSizes.small),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              color: Colors.white,
                              text: 'عدد الاسئلة',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            horizontalSmallSpacing(),
                            Icon(Icons.check_box_outlined, color: Colors.white),
                          ],
                        ),
                      ),
                      CustomText(
                        text: state.length.toString(),
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalMediumSpacing(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';
import 'package:hadith_app/app/features/questions/data/models/questions_model_response.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question, required this.index});
  final QuestionModelResponse question;
  final int index;
  @override
  Widget build(BuildContext context) {
    return UniversalContainer(
      borderColor: Colors.white,
      heightPortion: 0,
      widthPortion: .9,
      child: Padding(
        padding: const EdgeInsets.all(GeneralSizes.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UniversalButton(
                  onTap: () {},
                  title: 'حذف',
                  color: AppColors.primaryRich,
                  textColor: Colors.black,
                  borderColor: AppColors.primaryRich,
                  icon: Icons.delete_outline,
                  widthPortion: .25,
                ),
                CustomText(
                  text: 'السؤال ${index + 1} :',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            CustomText(text: question.createdAt.toString(), fontSize: 13),
            verticalMediumSpacing(),
            CustomText(
              text: 'نص السؤال :',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            verticalSmallSpacing(),
            CustomText(
              text: question.askerText.toString(),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            verticalMediumSpacing(),
            CustomText(
              text: 'نص الجواب : ',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            verticalSmallSpacing(),
            CustomText(
              text: question.answerText ?? 'لم يتم الاجابة على سؤالك بعد ',
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}

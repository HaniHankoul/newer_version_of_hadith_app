import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';

class QuestionHeaderSection extends StatelessWidget {
  const QuestionHeaderSection({super.key});

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
                  CustomText(text: 'حالة الاسئلة', fontWeight: FontWeight.w700),
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
                        text: '0',
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
                        text: '1',
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

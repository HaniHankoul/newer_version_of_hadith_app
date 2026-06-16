import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';
import 'package:hadith_app/app/features/questions/UI/widgets/question_header_section.dart';

import 'widgets/dialog_body.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalLargeSpacing(),
          QuestionHeaderSection(),
          verticalLargeSpacing(),
          UniversalContainer(
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
                        text: 'السؤال الاول :',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  CustomText(text: 'بتاريخ 12/6/2026', fontSize: 13),
                  verticalMediumSpacing(),
                  CustomText(
                    text: 'نص السؤال :',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  verticalSmallSpacing(),
                  CustomText(
                    text:
                        'نص نصن صن صن صن نص نصن صن نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نصن صن نص نص ',
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
                    text: 'لم يتم الاجابة على سؤالك بعد ',
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
          verticalLargeSpacing(),
          UniversalButton(
            widthPortion: 0.65,
            onTap: () {
              showDialog(context: context, builder: (context) => DialogBody());
            },
            title: 'اطرح سؤالك هنا',
            color: AppColors.primaryRich,
            textColor: Colors.black,
            borderColor: AppColors.primaryRich,
            icon: Icons.view_list_outlined,
          ),
        ],
      ),
    );
  }
}

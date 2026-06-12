import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';

import '../../../core/app_theme.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/universal_container.dart';
import 'widgets/dialog_body.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UniversalContainer(
            heightPortion: .35,
            widthPortion: .75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withAlpha(100),
                  radius: 50,
                  child: Icon(Icons.person, size: 50, color: AppColors.primary),
                ),
                verticalLargeSpacing(),
                CustomText(
                  text: ' لم تطرح اي اسئلة بعد ',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                verticalSmallSpacing(),
                CustomText(
                  fontSize: 13,
                  text: 'اطرح سؤالك الاول و سيظهر مع حالته و الاجابة عنه',
                ),
              ],
            ),
          ),
          verticalLargeSpacing(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GeneralSizes.large),
            child: UniversalButton(
              widthPortion: 0.65,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogBody(),
                );
              },
              title: 'اطرح سؤالك هنا',
              color: AppColors.primaryRich,
              textColor: Colors.black,
              borderColor: AppColors.primaryRich,
              icon: Icons.view_list_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

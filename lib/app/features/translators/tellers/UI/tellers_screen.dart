import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/translators_card.dart';

class TellersScreen extends StatelessWidget {
  const TellersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('تراجم الرواة'),
      body: Padding(
        padding: const EdgeInsets.all(GeneralSizes.large),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: GeneralSizes.small),
              child: TranslatorsCard(
                nameTitle: 'اسم الراوي',
                cardText:
                    'dsfsdfslajf;ljl;jfdjslakfl;aj;flsjf;jfljsffdjslakfl;aj;flsjf;jfljsffdjslakfl;aj;flsjf;jfljsffdjslakfl;aj;flsjf;jfljsffdjslakfl;aj;flsjf;jfljsffhdsgdfkh',
              ),
            );
          },
        ),
      ),
    );
  }
}

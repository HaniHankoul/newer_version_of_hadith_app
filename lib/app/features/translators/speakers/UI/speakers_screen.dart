import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/translators_card.dart';

import '../../../../core/app_theme.dart';

class MuhaddithsScreen extends StatelessWidget {
  const MuhaddithsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('تراجم المحدثين'),
      body: Padding(
        padding: const EdgeInsets.all(GeneralSizes.large),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: GeneralSizes.small),
              child: TranslatorsCard(
                nameTitle: 'اسم المحدث',
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

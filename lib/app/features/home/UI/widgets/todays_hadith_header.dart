import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_container.dart';

class TodaysHadithHeader extends StatelessWidget {
  const TodaysHadithHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: GeneralSizes.medium,
        left: GeneralSizes.large,
        right: GeneralSizes.large,
      ),
      child: UniversalContainer(
        heightPortion: .18,
        widthPortion: MediaQuery.of(context).size.width * .84,
        borderColor: Colors.black38,
        color: AppColors.primaryRich,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: 'حديث اليوم',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

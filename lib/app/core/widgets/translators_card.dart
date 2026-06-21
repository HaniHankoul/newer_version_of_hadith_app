import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

class TranslatorsCard extends StatelessWidget {
  const TranslatorsCard({
    super.key,
    required this.nameTitle,
    required this.cardText,
  });
  final String nameTitle;
  final String cardText;
  @override
  Widget build(BuildContext context) {
    return UniversalContainer(
      heightPortion: 0,
      widthPortion: .7,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GeneralSizes.medium,
          vertical: GeneralSizes.small + 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GeneralSizes.large,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusM),
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: CustomText(
                  text: nameTitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            verticalLargeSpacing(),
            CustomText(
              text: cardText,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            verticalMediumSpacing(),
            UniversalButton(
              widthPortion: .2,
              onTap: () {},
              title: 'نسخ ',
              icon: Icons.copy,
              color: transparent,
              textColor: Colors.black,
              borderColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

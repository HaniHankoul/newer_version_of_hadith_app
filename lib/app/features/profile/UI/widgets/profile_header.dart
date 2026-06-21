import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: GeneralSizes.small),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, color: AppColors.white),
                ),
              ),
              CustomText(
                text: 'بيانات الملف الشخصي',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ],
          ),
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: AppColors.black.withAlpha(200),
            radius: 50,
            child: Icon(Icons.person, size: 60, color: AppColors.black),
          ),
        ),
        verticalMediumSpacing(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UniversalButton(
              icon: Icons.delete,
              title: 'ازالة الصورة',
              onTap: () {},
              color: AppColors.white,
              textColor: AppColors.black,
              borderColor: AppColors.primary,
            ),
            horizontalLargeSpacing(),
            horizontalMediumSpacing(),
            UniversalButton(
              icon: Icons.photo,
              title: 'تعيين صورة',
              onTap: () {},
              color: AppColors.primary,
              textColor: AppColors.white,
              borderColor: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}

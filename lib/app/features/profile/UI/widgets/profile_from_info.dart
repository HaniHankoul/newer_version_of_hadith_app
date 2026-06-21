import 'package:flutter/material.dart';

import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ProfileFromInfo extends StatelessWidget {
  const ProfileFromInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: 'تغيير اسم المستخدم',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: GeneralSizes.small,
          ),
          child: CustomTextField(hintText: 'Hani Hankoul', icon: Icons.person),
        ),
        verticalSmallSpacing(),
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: 'تغيير البريد الالكتروني ',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: GeneralSizes.small,
          ),
          child: CustomTextField(
            hintText: 'hani@example.com',
            icon: Icons.mail,
          ),
        ),
        verticalSmallSpacing(),
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: ' تغيير تاريخ الميلاد',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: GeneralSizes.small,
          ),
          child: CustomTextField(
            hintText: '12/11/2002',
            icon: Icons.date_range,
          ),
        ),
        verticalMediumSpacing(),
      ],
    );
  }
}

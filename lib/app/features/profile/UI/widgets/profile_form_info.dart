import 'package:flutter/material.dart';
import 'package:hadith_app/app/features/profile/logic/profile_cubit_state.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ProfileFormInfo extends StatelessWidget {
  const ProfileFormInfo({super.key, required this.state});
  final ProfileCubitSuccess state;
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
          child: CustomTextField(
            hintText: state.profileResponse?.name ?? '',
            icon: HugeIcons.strokeRoundedUser02,
          ),
        ),
        verticalSmallSpacing(),
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: 'تغيير البريد الإلكتروني',
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
            hintText: state.profileResponse?.email ?? '',
            icon: HugeIcons.strokeRoundedMail01,
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
            hintText:
                '${state.profileResponse!.birthDate?.year.toString()}'
                '-${state.profileResponse!.birthDate?.month.toString().padLeft(2, '0')}'
                '-${state.profileResponse!.birthDate?.day.toString().padLeft(2, '0')}',
            icon: HugeIcons.strokeRoundedDateTime,
          ),
        ),
        verticalMediumSpacing(),
      ],
    );
  }
}

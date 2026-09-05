import 'package:flutter/material.dart';
import 'package:hadith_app/app/features/profile/logic/profile/profile_cubit_state.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ProfileFormInfo extends StatelessWidget {
  const ProfileFormInfo({
    super.key,
    required this.state,
    required this.nameController,
    required this.genderController,
    required this.birthDateController,
    required this.onBirthDateTap,
  });
  final ProfileCubitSuccess state;
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController birthDateController;
  final VoidCallback onBirthDateTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: ' اسم المستخدم',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: 2,
          ),
          child: CustomTextField(
            controller: nameController,
            hintText: state.profileResponse?.name ?? '',
            icon: HugeIcons.strokeRoundedUser02,
          ),
        ),
        verticalSmallSpacing(),
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: 'البريد الالكتروني',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: 2,
          ),
          child: CustomTextField(
            readOnly: true,
            hintText: state.profileResponse?.email ?? '',
            icon: HugeIcons.strokeRoundedUser02,
          ),
        ),
        verticalSmallSpacing(),
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: 'الجنس',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: 2,
          ),
          child: CustomTextField(
            controller: genderController,
            hintText: 'أدخل الجنس',
            icon: HugeIcons.strokeRoundedUser02,
          ),
        ),
        verticalSmallSpacing(),
        Padding(
          padding: const EdgeInsets.only(right: GeneralSizes.medium),
          child: CustomText(
            text: ' تاريخ الميلاد',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.medium,
            vertical: 2,
          ),
          child: CustomTextField(
            controller: birthDateController,
            readOnly: true,
            hintText: 'YYYY-MM-DD',
            icon: HugeIcons.strokeRoundedDateTime,
            onTap: onBirthDateTap,
            onFieldSubmitted: (_) => onBirthDateTap(),
          ),
        ),
        verticalMediumSpacing(),
      ],
    );
  }
}

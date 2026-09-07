import 'package:flutter/material.dart';
import 'package:hadith_app/app/features/profile/logic/profile/profile_cubit_state.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/app_theme.dart';
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
            icon: HugeIcons.strokeRoundedMail01,
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
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: genderController,
            builder: (context, value, child) {
              final gender = switch (value.text) {
                'ذكر' => 'male',
                'أنثى' => 'female',
                _ => value.text,
              };

              return Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButtonFormField<String>(
                  initialValue: gender == 'male' || gender == 'female'
                      ? gender
                      : null,
                  isExpanded: true,
                  onChanged: (selectedGender) {
                    if (selectedGender != null) {
                      genderController.text = selectedGender;
                    }
                  },
                  hint: Text(
                    'أدخل الجنس',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'cairo',
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('ذكر')),
                    DropdownMenuItem(value: 'female', child: Text('أنثى')),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: SizedBox(
                      width: 40,
                      height: 25,
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedUser02,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      maxHeight: 30,
                      maxWidth: 50,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 3,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.primaryLight,
                  ),
                ),
              );
            },
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

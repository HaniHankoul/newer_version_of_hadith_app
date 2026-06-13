import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/universal_button.dart';
import '../../../core/widgets/universal_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GeneralSizes.large + 8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            UniversalContainer(
              heightPortion: 0,
              widthPortion: .85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: AppColors.black.withAlpha(200),
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.black,
                      ),
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
                  verticalLargeSpacing(),
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Hani Hankoul',
                          hintStyle: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "cairo",
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          filled: true,
                          fillColor: AppColors.primaryLight,
                        ),
                      ),
                    ),
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: 'hani-haha@gmail.com',
                          hintStyle: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "cairo",
                          ),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: AppColors.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          filled: true,
                          fillColor: AppColors.primaryLight,
                        ),
                      ),
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '25/1/2003',
                          hintStyle: TextStyle(
                            color: AppColors.primary,
                            fontFamily: "cairo",
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          filled: true,
                          fillColor: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ),
                  verticalMediumSpacing(),
                ],
              ),
            ),
            verticalLargeSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GeneralSizes.large,
              ),
              child: UniversalButton(
                onTap: () {},
                height: 45,
                title: 'حفظ التغييرات في الملف الشخصي',
                color: AppColors.primaryRich,
                textColor: Colors.black,
                borderColor: AppColors.primaryRich,
                icon: Icons.person_3_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

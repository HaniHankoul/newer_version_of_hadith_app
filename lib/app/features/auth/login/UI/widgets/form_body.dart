import 'package:flutter/material.dart';
import 'package:hadith_app/app/features/auth/login/UI/widgets/divider_stack.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/helper/general_sizes.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/universal_container.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return UniversalContainer(
      heightPortion: 0,
      color: AppColors.accent,
      borderColor: AppColors.primary,
      widthPortion: 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          verticalMediumSpacing(),
          Padding(
            padding: const EdgeInsets.only(right: GeneralSizes.medium),
            child: CustomText(
              text: ' اسم المستخدم ',
              fontSize: 16,
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
                  hintText: 'ابحث عن حديث',
                  hintStyle: TextStyle(
                    color: AppColors.primary,
                    fontFamily: "cairo",
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.primary),
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
              text: 'البريد الالكتروني ',
              fontSize: 16,
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
                  hintText: 'ابحث عن حديث',
                  hintStyle: TextStyle(
                    color: AppColors.primary,
                    fontFamily: "cairo",
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.primary),
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
              text: ' تاريخ الميلاد',
              fontSize: 16,
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
                  hintText: 'ابحث عن حديث',
                  hintStyle: TextStyle(
                    color: AppColors.primary,
                    fontFamily: "cairo",
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.primary),
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
          DividerStack(),
          verticalMediumSpacing(),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(borderRadiusS),
                color: AppColors.primaryRich,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet_rounded),
                  horizontalMediumSpacing(),
                  CustomText(
                    text: 'تسجيل الدخول بحساب Google',
                    color: AppColors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
          verticalMediumSpacing(),
        ],
      ),
    );
  }
}

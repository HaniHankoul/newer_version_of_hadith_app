import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/widgets/custom_text.dart';
import 'widgets/form_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                Assets.assetsImagesSmallCircle,
                width: 160,
                height: 160,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                Assets.assetsImagesBigCircle,
                width: 160,
                height: 200,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GeneralSizes.medium,
                      vertical: GeneralSizes.large,
                    ),
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
                          text: 'الموسوعة الحديثية',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.textPrimaryDark,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  FormBody(),
                  Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UniversalButton(
                        widthPortion: .35,
                        height: 45,
                        onTap: () {},
                        title: 'انشاء حساب',
                        color: transparent,
                        textColor: AppColors.primary,
                        borderColor: AppColors.primaryRich,
                      ),
                      horizontalMediumSpacing(),
                      UniversalButton(
                        widthPortion: .35,
                        height: 45,
                        onTap: () {},
                        title: 'تسجيل الدخول',
                        color: AppColors.primaryRich,
                        textColor: AppColors.black,
                        borderColor: AppColors.primaryRich,
                      ),
                    ],
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

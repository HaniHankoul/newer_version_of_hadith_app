import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../logic/signup_cubit.dart';
import '../logic/signup_states.dart';
import 'widgets/signup_form_body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('جاري إنشاء الحساب...'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is SignupSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تم إنشاء الحساب بنجاح، مرحباً ${state.signupResponse.user.name}',
                ),
                backgroundColor: Colors.green,
              ),
            );

            context.go('/login');
          } else if (state is SignupErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
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
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                ),
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
                      const Spacer(),
                      const SignupFormBody(),
                      verticalLargeSpacing(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UniversalButton(
                            widthPortion: .35,
                            height: 45,
                            onTap: () {
                              context.go('/login');
                            },
                            title: 'تسجيل الدخول',
                            color: transparent,
                            textColor: AppColors.textPrimaryDark,
                            borderColor: AppColors.primaryRich,
                          ),
                        ],
                      ),
                      verticalMediumSpacing(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

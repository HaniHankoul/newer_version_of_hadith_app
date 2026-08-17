import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/helper/constants.dart';
import 'package:hadith_app/app/core/navigation/logic/navigation_cubit.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../data/models/login_model.dart';
import '../logic/login_cubit.dart';
import '../logic/login_states.dart';
import 'widgets/login_form_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static FormGroup createLoginForm() => FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  void _submitForm(BuildContext context, FormGroup form) {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    final email = (form.control('email').value ?? '').toString().trim();
    final password = (form.control('password').value ?? '').toString();

    context.read<LoginCubit>().login(
      Loginmodel(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = createLoginForm();

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoading) {
          } else if (state is LoginSuccess) {
            Constants().successBar('تم تسجيل الدخول بنجاح');
            context.go('/', extra: NavigationState.home);
          } else if (state is LoginError) {
            Constants().errorBar('حدث خطأ أثناء تسجيل الدخول');
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

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
                        Spacer(),
                        LoginFormBody(
                          formGroup: loginForm,
                          onSubmit: () => _submitForm(context, loginForm),
                        ),
                        verticalLargeSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UniversalButton(
                              widthPortion: .35,
                              height: 45,
                              onTap: () {
                                context.go('/signUp');
                              },
                              title: 'انشاء حساب',
                              color: transparent,
                              textColor: AppColors.primary,
                              borderColor: AppColors.primaryRich,
                            ),
                            horizontalLargeSpacing(),
                            UniversalButton(
                              widthPortion: .35,
                              height: 45,
                              onTap: () => _submitForm(context, loginForm),
                              title: 'تسجيل الدخول',
                              color: AppColors.primaryRich,
                              textColor: AppColors.black,
                              borderColor: AppColors.primaryRich,
                              isLoading: isLoading,
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
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/helper/general_sizes.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/universal_container.dart';
import '../../data/models/login_model.dart';
import '../../logic/login_cubit.dart';
import 'divider_stack.dart';

class LoginFormBody extends StatelessWidget {
  const LoginFormBody({super.key});

  FormGroup get _loginForm => FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  void _login(FormGroup form, BuildContext context) {
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
    return Expanded(
      flex: 10,
      child: SingleChildScrollView(
        child: UniversalContainer(
          heightPortion: 0,
          color: AppColors.accent,
          borderColor: AppColors.primary,
          widthPortion: 0.8,
          child: ReactiveForm(
            formGroup: _loginForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                verticalMediumSpacing(),

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
                    child: ReactiveTextField(
                      formControlName: 'email',
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'اكتب بريدك',
                        hintStyle: TextStyle(
                          color: AppColors.primary,
                          fontFamily: "cairo",
                        ),
                        prefixIcon: Icon(Icons.mail, color: AppColors.primary),
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        filled: true,
                        fillColor: AppColors.primaryLight,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'الرجاء إدخال البريد الإلكتروني',
                        ValidationMessage.email: (_) =>
                            'الرجاء إدخال بريد إلكتروني صحيح',
                      },
                    ),
                  ),
                ),
                verticalSmallSpacing(),

                Padding(
                  padding: const EdgeInsets.only(right: GeneralSizes.medium),
                  child: CustomText(
                    text: ' كلمة المرور',
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
                    child: ReactiveTextField(
                      formControlName: 'password',
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'اكتب كلمة المرور',
                        hintStyle: TextStyle(
                          color: AppColors.primary,
                          fontFamily: "cairo",
                        ),
                        prefixIcon: Icon(
                          Icons.password,
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        filled: true,
                        fillColor: AppColors.primaryLight,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'الرجاء إدخال كلمة المرور',
                        ValidationMessage.minLength: (_) =>
                            'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
                      },
                    ),
                  ),
                ),
                verticalMediumSpacing(),

                DividerStack(),
                verticalMediumSpacing(),

                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return Center(
                      child: GestureDetector(
                        onTap: form.valid ? () => _login(form, context) : null,
                        child: Opacity(
                          opacity: form.valid ? 1.0 : 0.6,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(
                                borderRadiusS,
                              ),
                              color: AppColors.primaryRich,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock_open_rounded),
                                horizontalMediumSpacing(),
                                CustomText(
                                  text: 'تسجيل الدخول',
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                verticalMediumSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

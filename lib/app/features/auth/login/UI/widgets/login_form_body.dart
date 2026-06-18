import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:hadith_app/app/features/auth/login/UI/widgets/divider_stack.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/helper/general_sizes.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/universal_container.dart';

class LoginFormBody extends StatelessWidget {
  const LoginFormBody({super.key});

  // تعريف النموذج مع قواعده و validators
  FormGroup get _loginForm => FormGroup({
    'username': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(3),
      ],
    ),
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(6),
      ],
    ),
  });

  // دالة تسجيل الدخول - نمرر context كمعامل
  void _login(FormGroup form, BuildContext context) {
    if (form.valid) {
      final username = form.control('username').value as String?;
      final email = form.control('email').value as String?;
      final password = form.control('password').value as String?;
      
      print('اسم المستخدم: $username');
      print('البريد الإلكتروني: $email');
      print('كلمة المرور: $password');
      
      // استخدام context الذي تم تمريره
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('جاري تسجيل الدخول...'),
          backgroundColor: Colors.green,
        ),
      );
    }
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
                
                // حقل اسم المستخدم
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
                    child: ReactiveTextField(
                      formControlName: 'username',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'اكتب اسمك',
                        hintStyle: TextStyle(
                          color: AppColors.primary,
                          fontFamily: "cairo",
                        ),
                        prefixIcon: Icon(Icons.person, color: AppColors.primary),
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
                        ValidationMessage.required: (_) => 'الرجاء إدخال اسم المستخدم',
                        ValidationMessage.minLength: (_) => 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل',
                      },
                    ),
                  ),
                ),
                verticalSmallSpacing(),

                // حقل البريد الإلكتروني
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
                        ValidationMessage.required: (_) => 'الرجاء إدخال البريد الإلكتروني',
                        ValidationMessage.email: (_) => 'الرجاء إدخال بريد إلكتروني صحيح',
                      },
                    ),
                  ),
                ),
                verticalSmallSpacing(),

                // حقل كلمة المرور
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
                        ValidationMessage.required: (_) => 'الرجاء إدخال كلمة المرور',
                        ValidationMessage.minLength: (_) => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
                      },
                    ),
                  ),
                ),
                verticalMediumSpacing(),
                
                DividerStack(),
                verticalMediumSpacing(),

                // زر تسجيل الدخول
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return Center(
                      child: GestureDetector(
                        // تمرير context إلى دالة _login
                        onTap: form.valid ? () => _login(form, context) : null,
                        child: Opacity(
                          opacity: form.valid ? 1.0 : 0.6,
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
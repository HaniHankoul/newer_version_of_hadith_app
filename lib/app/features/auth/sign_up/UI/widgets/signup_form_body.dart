import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../core/app_theme.dart';
import '../../../../../core/helper/general_sizes.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/universal_container.dart';

class SignupFormBody extends StatefulWidget {
  const SignupFormBody({super.key});

  @override
  State<SignupFormBody> createState() => _SignupFormBodyState();
}

class _SignupFormBodyState extends State<SignupFormBody> {
  final FormGroup form = FormGroup({
    'username': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.minLength(3)],
    ),
    'email': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.email],
    ),
    'gender': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'birthdate': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'password': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.minLength(6)],
    ),
    'confirmPassword': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  void _signup() {
    if (form.valid) {
      final username = form.control('username').value;
      final email = form.control('email').value;
      final gender = form.control('gender').value;
      final birthdate = form.control('birthdate').value;
      final password = form.control('password').value;

      print('اسم المستخدم: $username');
      print('البريد الإلكتروني: $email');
      print('الجنس: $gender');
      print('تاريخ الميلاد: $birthdate');
      print('كلمة المرور: $password');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إنشاء الحساب بنجاح! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _validatePasswordMatch() {
    final password = form.control('password').value;
    final confirmPassword = form.control('confirmPassword').value;
    
    if (password != null &&
        confirmPassword != null &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password != confirmPassword) {
      form.control('confirmPassword').setErrors({'mismatch': true});
    } else {
      form.control('confirmPassword').setErrors({});
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
            formGroup: form,
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
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
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
                        prefixIcon: Icon(Icons.email, color: AppColors.primary),
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
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
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

                // حقل الجنس - اختيار من خيارين
                Padding(
                  padding: const EdgeInsets.only(right: GeneralSizes.medium),
                  child: CustomText(
                    text: 'الجنس ',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: GeneralSizes.medium,
                    vertical: GeneralSizes.small,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primaryLight,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ReactiveRadioListTile<String>(
                            formControlName: 'gender',
                            value: 'ذكر',
                            title: const Text(
                              'ذكر',
                              style: TextStyle(
                                fontFamily: "cairo",
                                fontSize: 16,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: AppColors.primary,
                          ),
                        ),
                        Expanded(
                          child: ReactiveRadioListTile<String>(
                            formControlName: 'gender',
                            value: 'أنثى',
                            title: const Text(
                              'أنثى',
                              style: TextStyle(
                                fontFamily: "cairo",
                                fontSize: 16,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSmallSpacing(),

                // حقل تاريخ الميلاد - أصبح نص عادي
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
                    child: ReactiveTextField(
                      formControlName: 'birthdate',
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'مثال: 1990-01-01',
                        hintStyle: TextStyle(
                          color: AppColors.primary,
                          fontFamily: "cairo",
                        ),
                        prefixIcon: Icon(
                          Icons.date_range,
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
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        filled: true,
                        fillColor: AppColors.primaryLight,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) => 'الرجاء إدخال تاريخ الميلاد',
                      },
                    ),
                  ),
                ),
                verticalSmallSpacing(),

                // حقل كلمة المرور
                Padding(
                  padding: const EdgeInsets.only(right: GeneralSizes.medium),
                  child: CustomText(
                    text: 'كلمة المرور',
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
                      onChanged: (_) => _validatePasswordMatch(),
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
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
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
                verticalSmallSpacing(),

                // حقل تأكيد كلمة المرور
                Padding(
                  padding: const EdgeInsets.only(right: GeneralSizes.medium),
                  child: CustomText(
                    text: 'تاكيد كلمة المرور',
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
                      formControlName: 'confirmPassword',
                      obscureText: true,
                      onChanged: (_) => _validatePasswordMatch(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'اكتب كلمة المرور مرة أخرى',
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
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        filled: true,
                        fillColor: AppColors.primaryLight,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) => 'الرجاء تأكيد كلمة المرور',
                        ValidationMessage.minLength: (_) => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
                      },
                    ),
                  ),
                ),

                // عرض رسالة عدم تطابق كلمة المرور
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    final confirmPasswordControl = form.control('confirmPassword');
                    if (confirmPasswordControl.hasError('mismatch') &&
                        confirmPasswordControl.touched) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: GeneralSizes.medium,
                          top: 4,
                        ),
                        child: Text(
                          'كلمة المرور غير متطابقة',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "cairo",
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                verticalSmallSpacing(),

                // زر إنشاء الحساب
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return Center(
                      child: GestureDetector(
                        onTap: form.valid ? _signup : null,
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
                            child: Center(
                              child: CustomText(
                                text: 'انشاء الحساب',
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
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
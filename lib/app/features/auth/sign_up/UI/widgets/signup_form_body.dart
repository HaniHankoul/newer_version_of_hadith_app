import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/helper/general_sizes.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/universal_container.dart';
import '../../data/models/signup_model.dart';
import '../../logic/signup_cubit.dart';

class SignupFormBody extends StatelessWidget {
   SignupFormBody({super.key});

  FormGroup get _signupForm => FormGroup({
    'username': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'gender': FormControl<String>(validators: [Validators.required]),
    'birthdate': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });

  void _submit(FormGroup form, BuildContext context) {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    final birthDateText = (form.control('birthdate').value ?? '')
        .toString()
        .trim();
    final birthDate = DateTime.tryParse(birthDateText);

    if (birthDate == null) {
      form.control('birthdate').setErrors({'invalidDate': true});
      return;
    }

    final genderValue = (form.control('gender').value ?? '').toString();
    final mappedGender = genderValue == 'ذكر'
        ? 'male'
        : genderValue == 'أنثى'
        ? 'female'
        : genderValue;

    if (mappedGender != 'male' && mappedGender != 'female') {
      form.control('gender').setErrors({'invalidGender': true});
      return;
    }

    context.read<SignupCubit>().signup(
      Signupmodel(
        name: (form.control('username').value ?? '').toString().trim(),
        email: (form.control('email').value ?? '').toString().trim(),
        password: (form.control('password').value ?? '').toString(),
        gender: mappedGender,
        birthDate: birthDate,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, FormControl<String> control) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ar', 'SY'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2A4A5C),
              onPrimary: Colors.white,
              onSurface: Color(0xFF2A4A5C),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2A4A5C),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      control.value = formattedDate;
      control.markAsTouched();
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
            formGroup: _signupForm,
            child: Builder(
              builder: (formContext) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    verticalMediumSpacing(),

                    // اسم المستخدم
                    Padding(
                      padding: const EdgeInsets.only(right: GeneralSizes.medium),
                      child: CustomText(
                        text: 'اسم المستخدم',
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
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
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
                            ValidationMessage.required: (_) =>
                                'الرجاء إدخال اسم المستخدم',
                            ValidationMessage.minLength: (_) =>
                                'اسم المستخدم يجب أن يكون 3 أحرف على الأقل',
                          },
                        ),
                      ),
                    ),
                    verticalSmallSpacing(),

                    // البريد الالكتروني
                    Padding(
                      padding: const EdgeInsets.only(right: GeneralSizes.medium),
                      child: CustomText(
                        text: 'البريد الالكتروني',
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
                              borderRadius: BorderRadius.circular(12),
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
                            ValidationMessage.required: (_) =>
                                'الرجاء إدخال البريد الإلكتروني',
                            ValidationMessage.email: (_) =>
                                'الرجاء إدخال بريد إلكتروني صحيح',
                          },
                        ),
                      ),
                    ),
                    verticalSmallSpacing(),

                    // كلمة المرور
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
                              borderRadius: BorderRadius.circular(12),
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
                            ValidationMessage.required: (_) =>
                                'الرجاء إدخال كلمة المرور',
                            ValidationMessage.minLength: (_) =>
                                'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
                          },
                        ),
                      ),
                    ),
                    verticalSmallSpacing(),

                    // الجنس
                    Padding(
                      padding: const EdgeInsets.only(right: GeneralSizes.medium),
                      child: CustomText(
                        text: 'الجنس',
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
                                value: 'male',
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
                                value: 'female',
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

                    // تاريخ الميلاد
                    Padding(
                      padding: const EdgeInsets.only(right: GeneralSizes.medium),
                      child: CustomText(
                        text: 'تاريخ الميلاد',
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
                        child: ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            final birthdateControl = formGroup.control('birthdate') as FormControl<String>;
                            return GestureDetector(
                              onTap: () => _selectDate(context, birthdateControl),
                              child: AbsorbPointer(
                                child: ReactiveTextField(
                                  formControlName: 'birthdate',
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'اختر تاريخ الميلاد',
                                    hintStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontFamily: "cairo",
                                    ),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: AppColors.primary,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: AppColors.primary),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
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
                                    ValidationMessage.required: (_) =>
                                        'الرجاء اختيار تاريخ الميلاد',
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    verticalSmallSpacing(),

                    verticalSmallSpacing(),

                    // زر إنشاء الحساب
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return Center(
                          child: GestureDetector(
                            onTap: form.valid ? () => _submit(form, context) : null,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
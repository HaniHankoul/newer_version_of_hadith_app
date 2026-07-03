import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../app_theme.dart';

// ignore: must_be_immutable
class CustomReactiveForm extends StatelessWidget {
  CustomReactiveForm({
    super.key,
    required this.validators,
    required this.formKey,
    required this.hintText,
    required this.icon,
    required this.validationMessages,
    this.backgroundColor,
  });
  final String formKey;
  final List<Validator<dynamic>> validators;
  final Map<String, String Function(Object)>? validationMessages;
  final String hintText;
  final IconData icon;
  Color? backgroundColor;
  FormGroup get form =>
      FormGroup({formKey: FormControl<dynamic>(validators: validators)});

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ReactiveTextField(
          formControlName: formKey,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.primary, fontFamily: "cairo"),
            prefixIcon: Icon(icon, color: AppColors.primary),
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
            fillColor: backgroundColor ?? AppColors.white,
          ),
          validationMessages: validationMessages,
        ),
      ),
    );
  }
}

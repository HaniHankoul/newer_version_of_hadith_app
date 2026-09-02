import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onFieldSubmitted,
    this.controller,
    required this.hintText,
    required this.icon,
  });
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String hintText;
  final List<List<dynamic>> icon;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.primary, fontFamily: "cairo"),
          prefixIcon: SizedBox(
            width: 40,
            height: 25,
            child: HugeIcon(icon: icon, size: 20, color: AppColors.primary),
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 30, maxWidth: 50),
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
    );
  }
}

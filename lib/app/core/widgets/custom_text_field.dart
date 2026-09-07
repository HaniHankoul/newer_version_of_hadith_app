import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
    this.controller,
    this.suffixIcon,
    required this.hintText,
    required this.icon,
    this.prefixCallBack,
  });
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String hintText;
  final List<List<dynamic>> icon;
  final VoidCallback? prefixCallBack;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.primary, fontFamily: "cairo"),
          prefixIcon: IconButton(
            onPressed: prefixCallBack,
            icon: Icon(Icons.search, color: AppColors.primary, size: 26),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 3),
          ),
          filled: true,
          fillColor: AppColors.primaryLight,
        ),
      ),
    );
  }
}

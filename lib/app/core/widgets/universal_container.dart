import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';

// ignore: must_be_immutable
class UniversalContainer extends StatelessWidget {
  UniversalContainer({
    super.key,
    required this.heightPortion,
    required this.widthPortion,
    this.color,
    this.borderColor,
    required this.child,
  });
  final double heightPortion;
  final double widthPortion;
  final Widget child;
  Color? color = AppColors.white;
  Color? borderColor = Colors.black26;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: heightPortion == 0 ? null : screenHeight * heightPortion,
      width: screenWidth * widthPortion,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GeneralSizes.medium),
        border: Border.all(color: borderColor ?? Colors.black26),
        color: color ?? AppColors.white,
      ),
      child: child,
    );
  }
}

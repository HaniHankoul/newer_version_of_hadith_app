import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';

class UniversalContainer extends StatelessWidget {
  const UniversalContainer({
    super.key,
    required this.child,
    required this.heightPortion,
    required this.widthPortion,
  });
  final double heightPortion;
  final double widthPortion;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: heightPortion == 0 ? null : screenHeight * heightPortion,
      width: screenWidth * widthPortion,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GeneralSizes.medium),
        border: Border.all(color: Colors.black26),
        color: AppColors.white,
      ),
      child: child,
    );
  }
}

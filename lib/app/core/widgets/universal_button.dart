import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';

import '../app_theme.dart';

class UniversalButton extends StatelessWidget {
  const UniversalButton({
    super.key,
    this.width,
    required this.onTap,
    required this.title,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.icon,
  });
  final VoidCallback onTap;
  final double? width;
  final IconData icon;
  final String title;
  final Color color;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.black,
      focusColor: AppColors.black,
      highlightColor: AppColors.black,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: GeneralSizes.small,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadiusL),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Icon(icon, size: 18, color: textColor),
            SizedBox(width: GeneralSizes.small),
            CustomText(
              text: title,
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

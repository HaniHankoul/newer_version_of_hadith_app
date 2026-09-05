import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';

// ignore: must_be_immutable
class ContainerElement extends StatelessWidget {
  ContainerElement({
    super.key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.title,
    required this.icon,
    required this.backImag,
    required this.backColor,
    required this.color,
    this.isBig = false,
  });
  final VoidCallback onTap;
  final double width;
  final double height;
  final List<List<dynamic>> icon;
  final String title;
  final String backImag;
  final Color color;
  final Color backColor;
  bool isBig = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(GeneralSizes.medium),
      child: Container(
        height: height, //screenHeight * .2,
        width: width, //screenWidth * .42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GeneralSizes.medium),
          color: color,
          border: BoxBorder.all(color: Colors.black26),
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: .4)],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              backImag,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                backColor.withAlpha(80),
                BlendMode.srcIn,
              ),
              //  color: backColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GeneralSizes.small + 2,
              ),
              child: Column(
                crossAxisAlignment: isBig
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
                children: [
                  verticalMediumSpacing(),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryLight.withAlpha(500),
                    child: HugeIcon(
                      icon: icon,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  verticalMediumSpacing(),
                  CustomText(
                    text: title,
                    fontSize: isBig ? 18 : 14,
                    fontWeight: FontWeight.w700,
                    color: isBig ? Colors.white : Colors.black87,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

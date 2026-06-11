import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';

class ContainerElement extends StatelessWidget {
  const ContainerElement({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * .2,
      width: screenWidth * .42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GeneralSizes.medium),
        color: Colors.white,
        border: BoxBorder.all(color: Colors.black26),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: .4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryLight.withAlpha(500),
            child: Icon(icon, size: 28, color: AppColors.primary),
          ),
          CustomText(text: title, fontSize: 15, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}

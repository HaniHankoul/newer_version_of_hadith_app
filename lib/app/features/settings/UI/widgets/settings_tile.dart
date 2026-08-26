import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.color,
  });
  final VoidCallback onTap;
  final String title;
  final List<List<dynamic>> icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.06,
        width: width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: Colors.white,
          borderRadius: BorderRadius.circular(GeneralSizes.medium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HugeIcon(
                icon: icon,
                color: color ?? Colors.black,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomText(
                text: title,
                fontWeight: FontWeight.w600,
                color: color ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

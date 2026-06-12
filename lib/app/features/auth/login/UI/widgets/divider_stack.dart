import 'package:flutter/material.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/widgets/custom_text.dart';

class DividerStack extends StatelessWidget {
  const DividerStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Divider(
              color: AppColors.primary,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  color: AppColors.accent,
                  child: Center(
                    child: CustomText(
                      text: 'أو',
                      color: AppColors.textPrimaryDark,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

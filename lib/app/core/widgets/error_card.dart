import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import 'package:hugeicons/hugeicons.dart';

import '../helper/general_sizes.dart';
import 'custom_text.dart';
import 'universal_container.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      child: Center(
        child: UniversalContainer(
          heightPortion: 0.3,
          widthPortion: 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: message.contains('token') || message.contains('Token')
                    ? HugeIcons.strokeRoundedLogin01
                    : HugeIcons.strokeRoundedRssError,
                size: 50,
                color: Colors.red,
              ),
              verticalMediumSpacing(),
              CustomText(
                text: message.contains('token') || message.contains('Token')
                    ? 'يرجى تسجيل الدخول  '
                    : 'حدث خطأ ما',
                color: Colors.black,
              ),
              verticalSmallSpacing(),
              if (message.contains('token'))
                UniversalButton(
                  widthPortion: .35,
                  onTap: () {
                    context.push('/login');
                  },
                  borderColor: AppColors.primaryLight,
                  color: AppColors.primary,
                  textColor: Colors.black,
                  title: 'تسجيل الدخول',
                ),
            ],
          ),
        ).animate().scale(curve: Curves.easeInOut, duration: 300.ms),
      ),
    );
  }
}

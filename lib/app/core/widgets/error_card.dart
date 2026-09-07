import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
              if (message.contains('token'))
                UniversalContainer(
                  heightPortion: 0.1,
                  widthPortion: 0.5,
                  child: CustomText(
                    text: ' تسجيل الدخول  ',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ).animate().scale(curve: Curves.easeInOut, duration: 300.ms),
      ),
    );
  }
}

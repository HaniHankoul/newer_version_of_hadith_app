import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';

import '../helper/general_sizes.dart';
import 'custom_text.dart';
import 'universal_container.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.message});

  final String message;

  bool get _isAuthenticationError {
    final normalizedMessage = message.toLowerCase();

    return normalizedMessage.contains('token') ||
        normalizedMessage.contains('401') ||
        normalizedMessage.contains('unauthorized') ||
        normalizedMessage.contains('authentication') ||
        normalizedMessage.contains('not authenticated') ||
        normalizedMessage.contains('no access token') ||
        normalizedMessage.contains('access token');
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticationError = _isAuthenticationError;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      child: Center(
        child: UniversalContainer(
          heightPortion: 0.3,
          widthPortion: 0.7,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(
                  icon: isAuthenticationError
                      ? HugeIcons.strokeRoundedLogin01
                      : HugeIcons.strokeRoundedRssError,
                  size: 50,
                  color: isAuthenticationError ? AppColors.primary : Colors.red,
                ),

                verticalMediumSpacing(),

                CustomText(
                  text: isAuthenticationError
                      ? 'يرجى تسجيل الدخول للاستفادة من هذه الميزة'
                      : 'حدث خطأ ما',
                  color: Colors.black,
                ),

                if (isAuthenticationError) ...[
                  verticalMediumSpacing(),

                  GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: UniversalContainer(
                      heightPortion: 0,
                      widthPortion: 0.38,
                      color: AppColors.primary,
                      borderColor: AppColors.primary,
                      borderR: 12,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Center(
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ).animate().scale(curve: Curves.easeInOut, duration: 300.ms),
      ),
    );
  }
}

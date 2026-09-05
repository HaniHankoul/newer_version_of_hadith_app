import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';
import 'package:lottie/lottie.dart';

import '../helper/assets.dart';
import '../helper/general_sizes.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

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
              LottieBuilder.asset(
                width: 150,
                Assets.assetsImagesLottiesLoadingBlackCircle,
              ),
              verticalMediumSpacing(),
              CustomText(text: 'الرجاء الانتظار...', color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

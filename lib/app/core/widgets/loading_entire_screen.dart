import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helper/assets.dart';

class LoadingEntireScreen extends StatelessWidget {
  const LoadingEntireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ModalBarrier(dismissible: false, color: Color(0x99FFFFFF)),
        Center(
          child: SizedBox(
            height: 120,
            width: 120,
            child: LottieBuilder.asset(
              Assets.assetsImagesLottiesLoadingGrayCircles,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
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
                icon: HugeIcons.strokeRoundedRssError,
                size: 50,
                color: Colors.red,
              ),
              verticalMediumSpacing(),
              CustomText(text: message, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

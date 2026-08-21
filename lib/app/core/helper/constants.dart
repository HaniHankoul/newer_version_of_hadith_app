import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:toastification/toastification.dart';


class Constants {
  final String appName = "Hadith App";
  void successBar(String message) {
    toastification.show(
      title: CustomText(text: message, color: Colors.white),
      backgroundColor: Colors.green,
      foregroundColor: Colors.green,
      borderRadius: BorderRadius.circular(borderRadiusL),

      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void errorBar(String message) {
    toastification.show(
      title: CustomText(text: message, color: Colors.white),
      backgroundColor: Colors.red,
      foregroundColor: Colors.red,
      borderRadius: BorderRadius.circular(borderRadiusL),
      icon: Icon(Icons.error, color: Colors.white),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}

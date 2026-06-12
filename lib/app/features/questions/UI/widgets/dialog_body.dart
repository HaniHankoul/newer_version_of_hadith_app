import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';

class DialogBody extends StatelessWidget {
  const DialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: AppColors.primaryLight,
      title: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.list, color: AppColors.white),
                ),
              ),
              CustomText(
                text: 'اطرح سؤالك هنا  ',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ],
          ),
          CustomText(
            text: 'اكتب سؤالك بوضوح ليتمكن المختص من الاجابة عليه بشكل ادق',
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
      content: TextFormField(
        textDirection: TextDirection.rtl,
        maxLines: 5,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'اكتب سؤالك ',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: AppColors.primary,
            fontFamily: "cairo",
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusM),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusM),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusM),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      actions: [
        UniversalButton(
          onTap: () {
            // Handle question submission logic here
            Navigator.pop(context);
          },
          title: 'إرسال',
          color: AppColors.primaryRich,
          textColor: Colors.black,
          borderColor: AppColors.primaryRich,
          icon: Icons.send,
          widthPortion: .3,
        ),
      ],
    );
  }
}

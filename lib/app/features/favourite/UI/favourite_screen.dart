import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UniversalContainer(
            heightPortion: .35,
            widthPortion: .75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withAlpha(100),
                  radius: 50,
                  child: Icon(Icons.person, size: 50, color: AppColors.primary),
                ),
                verticalLargeSpacing(),
                CustomText(
                  text: ' لم تضف اي احاديث',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                verticalSmallSpacing(),
                CustomText(
                  fontSize: 13,
                  text: 'أضف احاديثك المفضلة للوصول السريع اليها',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

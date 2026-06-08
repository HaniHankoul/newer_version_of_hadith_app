import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/features/home_screen/UI/widgets/container_element.dart';

import '../../../core/app_theme.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralSizes.large,
            vertical: GeneralSizes.medium,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'ابحث عن حديث',
                hintStyle: TextStyle(
                  color: AppColors.primary,
                  fontFamily: "cairo",
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: GeneralSizes.large,
          crossAxisSpacing: GeneralSizes.large,
          padding: EdgeInsets.symmetric(horizontal: GeneralSizes.large),
          children: [
            ContainerElement(icon: Icons.book, title: "الأحاديث"),
            ContainerElement(icon: Icons.person, title: "الكتب و المصادر"),
            ContainerElement(icon: Icons.person, title: "الكتب و المصادر"),
            ContainerElement(icon: Icons.person, title: "الكتب و المصادر"),
            ContainerElement(icon: Icons.person, title: "الكتب و المصادر"),
            ContainerElement(icon: Icons.person, title: "الكتب و المصادر"),
          ],
        ),
      ],
    );
  }
}

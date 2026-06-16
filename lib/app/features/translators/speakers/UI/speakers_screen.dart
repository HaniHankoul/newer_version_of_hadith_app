import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import '../../../../core/app_theme.dart';

class SpeakersScreen extends StatelessWidget {
  const SpeakersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('تراجم المحدثين'),
      body: Padding(
        padding: const EdgeInsets.all(GeneralSizes.large),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: GeneralSizes.small),
              child: UniversalContainer(
                heightPortion: 0,
                widthPortion: .2,
                child: Column(
                  children: [
                    Text('اسم المحدث'),
                    Text('تاريخ الميلاد - تاريخ الوفاة'),
                    Text('مكان الميلاد - مكان الوفاة'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

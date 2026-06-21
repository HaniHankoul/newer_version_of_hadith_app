import 'package:flutter/material.dart';
import 'package:hadith_app/app/features/profile/UI/widgets/profile_from_info.dart';
import 'package:hadith_app/app/features/profile/UI/widgets/profile_header.dart';

import '../../../core/app_theme.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/universal_button.dart';
import '../../../core/widgets/universal_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GeneralSizes.large + 8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            UniversalContainer(
              heightPortion: 0,
              widthPortion: .85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProfileHeader(),
                  verticalLargeSpacing(),
                  ProfileFromInfo(),
                ],
              ),
            ),
            verticalLargeSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GeneralSizes.large,
              ),
              child: UniversalButton(
                onTap: () {},
                height: 45,
                title: 'حفظ التغييرات في الملف الشخصي',
                color: AppColors.primaryRich,
                textColor: Colors.black,
                borderColor: AppColors.primaryRich,
                icon: Icons.person_3_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/features/profile/UI/widgets/profile_form_info.dart';
import 'package:hadith_app/app/features/profile/UI/widgets/profile_header.dart';
import 'package:hadith_app/app/features/profile/logic/profile_cubit.dart';
import 'package:hadith_app/app/features/profile/logic/profile_cubit_state.dart';

import '../../../core/app_theme.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/universal_button.dart';
import '../../../core/widgets/universal_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileCubitState>(
      builder: (context, state) {
        if (state is ProfileCubitLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
        }
        return Padding(
          padding: const EdgeInsets.only(top: GeneralSizes.large + 8),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children:
                  [
                        UniversalContainer(
                          heightPortion: 0,
                          widthPortion: .85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ProfileHeader(),
                              verticalLargeSpacing(),
                              ProfileFormInfo(),
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
                      ]
                      .animate(interval: 100.ms)
                      .fade(duration: 250.ms)
                      .slide(begin: Offset(0, 0.3), duration: 200.ms),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';

import '../logic/navigation_cubit.dart';
import 'navigation_element.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GeneralSizes.medium),
              border: Border.all(color: AppColors.primary),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavigationElements(
                  index: NavigationState.profile,
                  state: state,
                  title: 'ملفي',
                  icon: Icons.person,
                ),
                NavigationElements(
                  index: NavigationState.favourites,
                  state: state,
                  title: 'المفضلة',
                  icon: Icons.bookmark,
                ),
                NavigationElements(
                  index: NavigationState.home,
                  state: state,
                  title: 'الرئيسية',
                  icon: Icons.home,
                ),
                NavigationElements(
                  index: NavigationState.questions,
                  state: state,
                  title: 'الأسئلة',
                  icon: Icons.question_answer,
                ),
                NavigationElements(
                  index: NavigationState.settings,
                  state: state,
                  title: 'الإعدادات',
                  icon: Icons.settings,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../app_theme.dart';
import '../../helper/general_sizes.dart';
import '../logic/navigation_cubit.dart';

// ignore: must_be_immutable
class NavigationElements extends StatelessWidget {
  NavigationState index;
  NavigationState state;
  String title;
  List<List<dynamic>> icon;
  NavigationElements({
    required this.index,
    required this.state,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NavigationCubit>().navigate(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: state == index ? 70 : 55,
        decoration: BoxDecoration(
          color: state == index ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadiusL),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              HugeIcon(
                icon: icon,
                size: 23,
                color: state == index ? AppColors.white : AppColors.black,
              ),
              CustomText(
                text: title,
                color: state == index ? AppColors.white : AppColors.black,
                fontSize: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

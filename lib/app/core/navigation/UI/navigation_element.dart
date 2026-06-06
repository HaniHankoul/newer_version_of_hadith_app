import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_theme.dart';
import '../../helper/general_sizes.dart';
import '../logic/navigation_cubit.dart';

// ignore: must_be_immutable
class NavigationElements extends StatelessWidget {
  NavigationState index;
  NavigationState state;
  String title;
  IconData icon;
  NavigationElements({
    required this.index,
    required this.state,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        context.read<NavigationCubit>().navigate(index);
      },
      hoverElevation: 2,
      splashColor: AppColors.grey,
      color: state == index ? AppColors.primaryLight : AppColors.primary,
      elevation: state == index ? 6 : 0,
      hoverColor: transparent.withAlpha(40),
      mouseCursor: SystemMouseCursors.click,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GeneralSizes.small,
          vertical: 4.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: state == index ? AppColors.white : transparent,
              radius: 15,
              child: Icon(icon, color: Colors.black),
            ),
            SizedBox(width: 8),
            Text(title, style: TextStyle(color: AppColors.black)),
          ],
        ),
      ),
    );
  }
}

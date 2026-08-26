import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_theme.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(
        ThemeState(primary: AppColors.primary, secondary: AppColors.secondary),
      );

  void selectPrimary(Color color) {
    AppColors.updateTheme(primary: color, secondary: state.secondary);
    emit(state.copyWith(primary: color));
  }

  void selectSecondary(Color color) {
    AppColors.updateTheme(primary: state.primary, secondary: color);
    emit(state.copyWith(secondary: color));
  }

  void applyTheme({required Color primary, required Color secondary}) {
    AppColors.updateTheme(primary: primary, secondary: secondary);
    emit(ThemeState(primary: primary, secondary: secondary));
  }
}

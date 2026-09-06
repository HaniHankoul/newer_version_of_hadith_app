import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_theme.dart';
import '../../helper/shared/shared_init.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(
        ThemeState(primary: AppColors.primary, secondary: AppColors.secondary),
      );

  Future<void> loadTheme() async {
    final (primaryValue, secondaryValue) = await UserPreferences.getTheme();
    if (isClosed || primaryValue == null || secondaryValue == null) return;

    applyTheme(primary: Color(primaryValue), secondary: Color(secondaryValue));
  }

  Future<void> selectPrimary(Color color) async {
    AppColors.updateTheme(primary: color, secondary: state.secondary);
    emit(state.copyWith(primary: color));
    await _saveTheme();
  }

  Future<void> selectSecondary(Color color) async {
    AppColors.updateTheme(primary: state.primary, secondary: color);
    emit(state.copyWith(secondary: color));
    await _saveTheme();
  }

  Future<void> applyTheme({
    required Color primary,
    required Color secondary,
  }) async {
    AppColors.updateTheme(primary: primary, secondary: secondary);
    emit(ThemeState(primary: primary, secondary: secondary));
    await _saveTheme();
  }

  Future<void> _saveTheme() {
    return UserPreferences.saveTheme(
      primaryColor: state.primary.toARGB32(),
      secondaryColor: state.secondary.toARGB32(),
    );
  }
}

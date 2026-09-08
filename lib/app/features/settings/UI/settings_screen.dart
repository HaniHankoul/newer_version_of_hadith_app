import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/app_theme.dart';
import '../../../core/font_size/logic/font_size_cubit.dart';
import '../../../core/font_size/logic/font_size_state.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/helper/shared/shared_init.dart';
import '../../../core/widgets/loading_card.dart';
import '../../home/Logic/access_token_bloc/acces_states.dart';
import '../../home/Logic/access_token_bloc/access_bloc.dart';
import '../logic/setting_cubit.dart';
import '../logic/setting_states.dart';
import 'widgets/settings_tile.dart';
import 'widgets/theme_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is SettingLoading) {
          return LoadingCard();
        } else if (state is SettingError) {
          return ErrorCard(message: state.errorMessage);
        }
        return Column(
          children: [
            BlocBuilder<AccessBloc, AccessState>(
              builder: (context, state) {
                return Column(
                  children: [
                    verticalSmallSpacing(),
                    SettingsTile(
                      onTap: () {},
                      title: 'الاشعارات',
                      icon: HugeIcons.strokeRoundedNotification01,
                    ),
                    verticalSmallSpacing(),
                    ThemeCard(),
                    verticalSmallSpacing(),
                    SettingsTile(
                      onTap: () => _showFontSizeSheet(context),
                      title: 'حجم الخط',
                      icon: HugeIcons.strokeRoundedPencil,
                      color: Colors.black,
                    ),
                    verticalSmallSpacing(),

                    state is AccessSuccess && state.token != null
                        ? SettingsTile(
                            onTap: () {
                              AuthStorage.clearTokens();
                              context.go('/login');
                            },
                            title: 'تسجيل خروج',
                            icon: HugeIcons.strokeRoundedLogout01,
                            color: Colors.red,
                          )
                        : SettingsTile(
                            onTap: () {
                              context.push('/login');
                            },
                            title: 'تسجيل دخول',
                            icon: HugeIcons.strokeRoundedLogin01,
                            color: Colors.black,
                          ),
                    verticalLargeSpacing(),
                    SettingsTile(
                      onTap: () {},
                      title: 'عن التطبيق',
                      icon: HugeIcons.strokeRoundedInformationCircle,
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showFontSizeSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.secondary,
      builder: (_) => const _FontSizeSheet(),
    );
  }
}

class _FontSizeSheet extends StatelessWidget {
  const _FontSizeSheet();

  @override
  Widget build(BuildContext context) {
    final hadithFontSize = context.watch<FontSizeCubit>().state.fontSize;

    return BlocBuilder<FontSizeCubit, FontSizeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'حجم الخط',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Cairo',
                  fontSize: hadithFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.fontSize.toStringAsFixed(0),
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Cairo',
                  fontSize: state.fontSize,
                ),
              ),
              Slider(
                value: state.fontSize,
                min: FontSizeCubit.minimumFontSize,
                max: FontSizeCubit.maximumFontSize,
                divisions: 16,
                activeColor: AppColors.primary,
                onChanged: context.read<FontSizeCubit>().selectFontSize,
              ),
            ],
          ),
        );
      },
    );
  }
}

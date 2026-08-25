import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helper/shared/shared_init.dart';
import '../../../core/widgets/drawer/drawer_button.dart';
import '../../../core/widgets/loading_card.dart';
import '../../../core/widgets/universal_container.dart';
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
          return Center(child: Text(state.errorMessage));
        }
        return Column(
          children: [
            BlocBuilder<AccessBloc, AccessState>(
              builder: (context, state) {
                return Column(
                  children: [
                    ThemeCard(),
                    state is AccessSuccess && state.token != null
                        ? SettingsTile(
                            onTap: () {
                              AuthStorage.clearTokens();
                              context.go('/login');
                            },
                            title: 'تسجيل خروج',
                            icon: Icons.logout,
                            color: Colors.red,
                          )
                        : CustomDrawerButton(
                            onTap: () {
                              context.push('/login');
                            },
                            title: 'تسجيل دخول',
                            icon: Icons.door_back_door,
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
}

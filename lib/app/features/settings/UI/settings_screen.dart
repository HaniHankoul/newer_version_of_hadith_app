import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/drawer/drawer_button.dart';
import '../../home/Logic/access_token_bloc/acces_states.dart';
import '../../home/Logic/access_token_bloc/access_bloc.dart';
import '../logic/setting_cubit.dart';
import '../logic/setting_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is SettingLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SettingError) {
          return Center(child: Text(state.errorMessage));
        }
        return Column(
          children: [
            BlocBuilder<AccessBloc, AccessState>(
              builder: (context, state) {
                if (state is AccessSuccess && state.token != null) {
                  return CustomDrawerButton(
                    onTap: () {},
                    title: 'تسجيل الخروج ',
                    icon: Icons.door_back_door,
                    color: Colors.red,
                  );
                }
                return CustomDrawerButton(
                  onTap: () {
                    context.push('/login');
                  },
                  title: 'تسجيل دخول',
                  icon: Icons.door_back_door,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

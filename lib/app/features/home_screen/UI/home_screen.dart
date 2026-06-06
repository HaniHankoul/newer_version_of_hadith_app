import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/UI/navigation_panel.dart';
import '../../../core/navigation/logic/navigation_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Center(child: Text('welcome')),
              Expanded(
                child: body(state),
              ), // Spacer to push the navigation panel to the bottom
              NavigationPanel(),
            ],
          ),
        );
      },
    );
  }
}

Widget body(NavigationState state) {
  switch (state) {
    case NavigationState.home:
      return Center(child: Text('Home Content'));
    case NavigationState.settings:
      return Center(child: Text('Settings Content'));
    case NavigationState.profile:
      return Center(child: Text('Profile Content'));
    default:
      return Center(child: Text('Unknown State'));
  }
}

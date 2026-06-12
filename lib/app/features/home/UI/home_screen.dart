import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_drawer.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/features/favourite/UI/favourite_screen.dart';
import 'package:hadith_app/app/features/profile/UI/profile_screen.dart';
import 'package:hadith_app/app/features/questions/UI/questions_screen.dart';
import '../../../core/navigation/UI/navigation_panel.dart';
import '../../../core/navigation/logic/navigation_cubit.dart';
import 'home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              title: CustomText(
                text: 'الرئيسية',
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Color(0xffFCF7F5),
              shape: RoundedRectangleBorder(),
            ),
          ),
          drawer: CustomDrawer(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(child: SingleChildScrollView(child: body(state))),
                NavigationPanel(),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget body(NavigationState state) {
  switch (state) {
    case NavigationState.home:
      return HomeBody();
    case NavigationState.settings:
      return Center(child: Text('Settings Content'));
    case NavigationState.profile:
      return ProfileScreen();
    case NavigationState.questions:
      return QuestionsScreen();
    case NavigationState.favourites:
      return FavouriteScreen();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_theme.dart';
import '../../../core/navigation/UI/navigation_panel.dart';
import '../../../core/navigation/logic/navigation_cubit.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/drawer/custom_drawer.dart';
import '../../favourite/UI/favourite_screen.dart';
import '../../profile/UI/profile_screen.dart';
import '../../profile/logic/profile_cubit.dart';
import '../../questions/UI/questions_screen.dart';
import '../../settings/UI/settings_screen.dart';
import '../../settings/logic/setting_cubit.dart';
import '../Logic/access_token_bloc/access_bloc.dart';
import '../Logic/search_bloc/search_cubit.dart';
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
                text: titleSelect(state),
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
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AccessBloc()..getAccessToken()),
          BlocProvider(create: (context) => SearchCubit()),
        ],
        child: HomeBody(),
      );
    case NavigationState.settings:
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingCubit()..updateSetting()),
          BlocProvider(create: (context) => AccessBloc()..getAccessToken()),
        ],
        child: SettingsScreen(),
      );

    case NavigationState.profile:
      return BlocProvider(
        create: (context) => ProfileCubit()..updateProfile(),
        child: ProfileScreen(),
      );
    case NavigationState.questions:
      return QuestionsScreen();
    case NavigationState.favourites:
      return FavouriteScreen();
  }
}

String titleSelect(NavigationState state) {
  switch (state) {
    case NavigationState.home:
      return 'الرئيسية';
    case NavigationState.settings:
      return 'الاعدادات';
    case NavigationState.profile:
      return 'الملف الشخصي ';
    case NavigationState.questions:
      return 'الأسئلة';
    case NavigationState.favourites:
      return 'المفضلة';
  }
}

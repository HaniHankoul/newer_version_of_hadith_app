import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/features/auth/sign_up/UI/signup_screen.dart';
import 'package:hadith_app/app/features/favourite/UI/favourite_screen.dart';
import 'package:hadith_app/app/features/search/advanced_search/UI/advanced_search_screen.dart';
import 'package:hadith_app/app/features/translators/tellers/UI/tellers_screen.dart';

import '../../features/auth/login/UI/login_screen.dart';
import '../../features/home/UI/home_screen.dart';
import '../../features/translators/speakers/UI/speakers_screen.dart';
import '../widgets/detail_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => SignupScreen()),
    GoRoute(path: '/speakers', builder: (context, state) => SpeakersScreen()),
    GoRoute(path: '/tellers', builder: (context, state) => TellersScreen()),
    GoRoute(
      path: '/hadithDetail',
      builder: (context, state) {
        final title = state.extra as String;
        return DetailScreen(title: title);
      },
    ),
    GoRoute(
      path: '/advancedSearch',
      builder: (context, state) => AdvancedSearchScreen(),
    ),
    GoRoute(
      path: '/favourites',
      builder: (context, state) => FavouriteScreen(),
    ),
  ],
);

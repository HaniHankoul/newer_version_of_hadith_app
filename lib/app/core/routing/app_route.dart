import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/features/auth/sign_up/UI/signup_screen.dart';

import '../../features/auth/login/UI/login_screen.dart';
import '../../features/home/UI/home_screen.dart';
import '../../features/translators/speakers/UI/speakers_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => SignupScreen()),
    GoRoute(path: '/speakers', builder: (context, state) => SpeakersScreen()),
  ],
);

import 'package:go_router/go_router.dart';

import '../../features/auth/login/UI/login_screen.dart';
import '../../features/home/UI/home_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
  ],
);

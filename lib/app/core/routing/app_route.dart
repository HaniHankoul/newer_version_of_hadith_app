import 'package:go_router/go_router.dart';

import '../../features/home_screen/UI/home_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => HomeScreen())],
);

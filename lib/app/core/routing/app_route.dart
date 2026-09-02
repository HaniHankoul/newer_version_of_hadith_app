import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login/UI/login_screen.dart';
import '../../features/auth/sign_up/UI/signup_screen.dart';
import '../../features/favourite/UI/favourite_screen.dart';
import '../../features/favourite/data/models/favorite_model.dart' as favorite;
import '../../features/favourite/logic/favorite_cubit.dart';
import '../../features/home/UI/home_screen.dart';
import '../../features/home/data/models/search_model.dart';
import '../../features/search/advanced_search/UI/advanced_search_screen.dart';
import '../../features/search/advanced_search/logic/advanced_search_cubit.dart';
import '../../features/translators/speakers/UI/speakers_screen.dart';
import '../../features/translators/tellers/UI/tellers_screen.dart';
import '../../features/upgrade_request/UI/upgrade_request_screen.dart';
import '../../features/upgrade_request/logic/upgrade_cubit.dart';
import '../navigation/logic/navigation_cubit.dart';
import '../widgets/detail_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final selectedState = state.extra is NavigationState
            ? state.extra as NavigationState
            : NavigationState.home;

        final navCubit = context.read<NavigationCubit>();
        navCubit.navigate(selectedState);

        return const HomeScreen();
      },
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/speakers',
      builder: (context, state) => const SpeakersScreen(),
    ),
    GoRoute(
      path: '/tellers',
      builder: (context, state) => const TellersScreen(),
    ),
    GoRoute(
      path: '/hadithDetail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        final title = data['title'] as String;
        final item =
            data['item'] as Item? ??
            _toSearchItem(data['favoriteItem'] as favorite.Item);
        return BlocProvider(
          create: (context) => FavoriteCubit(),
          child: DetailScreen(
            title: title,
            item: item,
            isFavorite: data['favoriteItem'] != null,
          ),
        );
      },
    ),
    GoRoute(
      path: '/advancedSearch',
      builder: (context, state) => BlocProvider(
        create: (context) => AdvancedSearchCubit()..loadFilters(),
        child: const AdvancedSearchScreen(),
      ),
    ),
    GoRoute(
      path: '/favourites',
      builder: (context, state) => BlocProvider(
        create: (context) => FavoriteCubit()..showFavorite(),
        child: const FavouriteScreen(),
      ),
    ),
    GoRoute(
      path: '/upgradeRequestScreen',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => UpgradeCubit(),
          child: UpgradeRequestScreen(),
        );
      },
    ),
  ],
);

Item _toSearchItem(favorite.Item item) => Item(
  id: item.id,
  text: item.text,
  normalText: item.normalText,
  hadithNumber: item.hadithNumber,
  type: item.type,
  sanad: item.sanad,
  book: item.book == null
      ? null
      : Book(id: item.book!.id, name: item.book!.name),
  rawi: item.rawi == null
      ? null
      : Book(id: item.rawi!.id, name: item.rawi!.name),
  ruling: item.ruling == null
      ? null
      : Book(id: item.ruling!.id, name: item.ruling!.name),
  muhaddith: item.muhaddith == null
      ? null
      : Book(id: item.muhaddith!.id, name: item.muhaddith!.name),
  topics: item.topics
      ?.whereType<Map>()
      .map((topic) => Book.fromJson(Map<String, dynamic>.from(topic)))
      .toList(),
  hasExplanation: item.hasExplanation,
  hasSubValid: item.hasSubValid,
);

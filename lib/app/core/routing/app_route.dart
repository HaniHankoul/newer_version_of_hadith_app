import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login/UI/login_screen.dart';
import '../../features/auth/sign_up/UI/signup_screen.dart';
import '../../features/fake_hadith/UI/fake_hadith_screen.dart';
import '../../features/fake_hadith/logic/fake_hadtith_cubit.dart';
import '../../features/books_resource/UI/books_screen.dart';
import '../../features/books_resource/UI/book_details_screen.dart';
import '../../features/books_resource/data/models/book_model.dart';
import '../../features/books_resource/logic/book_details_cubit.dart';
import '../../features/books_resource/logic/book_cubit.dart';
import '../../features/favourite/UI/favourite_screen.dart';
import '../../features/favourite/data/models/favorite_model.dart' as favorite;
import '../../features/favourite/logic/favorite_cubit.dart';
import '../../features/home/UI/home_screen.dart';
import '../../features/home/data/models/search_model.dart';
import '../../features/hadith_detail/logic/hadith_detail_cubit.dart';
import '../../features/search/advanced_search/UI/advanced_search_screen.dart';
import '../../features/search/advanced_search/logic/advanced_search_cubit.dart';
import '../../features/translators/muhaddith/UI/muhaddiths_screen.dart';
import '../../features/translators/muhaddith/logic/muhaddith_cubit.dart';
import '../../features/translators/tellers/UI/rawi_screen.dart';
import '../../features/translators/tellers/logic/rawi_cubit.dart';
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
      path: '/muhaddiths',
      builder: (context, state) => BlocProvider(
        create: (context) => MuhaddithCubit()..fetchMuhaddiths(),
        child: const MuhaddithsScreen(),
      ),
    ),
    GoRoute(
      path: '/rawi',
      builder: (context, state) => BlocProvider(
        create: (context) => RawiCubit()..fetchRawis(),
        child: const RawiScreen(),
      ),
    ),
    GoRoute(
      path: '/books',
      builder: (context, state) => BlocProvider(
        create: (context) => BookCubit()..fetchBooks(),
        child: const BooksScreen(),
      ),
    ),
    GoRoute(
      path: '/bookDetails',
      builder: (context, state) {
        final book = state.extra as BookModel;
        return BlocProvider(
          create: (context) =>
              BookDetailsCubit(bookId: book.id!)..fetchBookHadiths(),
          child: BookDetailsScreen(book: book),
        );
      },
    ),
    GoRoute(
      path: '/hadithDetail',
      builder: (context, state) {
        final extra = state.extra;
        final hadithId = extra is String
            ? extra
            : extra is Map<String, dynamic>
            ? extra['hadithId'] as String? ??
                  (extra['favoriteItem'] as favorite.Item?)?.id
            : extra is favorite.Item
            ? extra.id
            : null;
        return BlocProvider(
          create: (context) =>
              HadithDetailCubit(hadithId: hadithId ?? '')..fetchHadithDetail(),
          child: BlocProvider(
            create: (context) => FavoriteCubit(),
            child: DetailScreen(hadithId: hadithId),
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
          create: (context) => UpgradeCubit()..loadRequests(),
          child: UpgradeRequestScreen(),
        );
      },
    ),
    GoRoute(
      path: '/fakeHadith',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => FakeHadtithCubit()..loadFakeHadith(),
          child: FakeHadithScreen(),
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

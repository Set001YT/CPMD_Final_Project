import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/home/domain/entities/movie.dart';
import '../../features/home/domain/entities/movie_category.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/movie_list_page.dart';
import '../../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../widgets/cinewave_splash.dart';
import '../widgets/main_shell.dart';
import 'routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, _) => const CineWaveSplash(),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (_, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (_, animation, _, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (_, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterPage(),
          transitionsBuilder: (_, animation, _, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.movieDetail,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final movie = state.extra is Movie ? state.extra as Movie : null;
          return MovieDetailPage(movieId: id, initial: movie);
        },
      ),
      GoRoute(
        path: AppRoutes.movieList,
        builder: (context, state) {
          final slug = state.pathParameters['category']!;
          final category = MovieCategory.fromSlug(slug) ?? MovieCategory.popular;
          return MovieListPage(category: category);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.search,
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SearchPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.favorites,
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: const FavoritesPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            pageBuilder: (_, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri}')),
    ),
  );
});

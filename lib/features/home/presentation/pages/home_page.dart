import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_category.dart';
import '../providers/home_providers.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/horizontal_movie_list.dart';
import '../widgets/section_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _goToDetail(BuildContext context, Movie movie) {
    context.push(AppRoutes.movieDetailPath(movie.id), extra: movie);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(trendingMoviesProvider);
    final popular = ref.watch(popularMoviesProvider);
    final upcoming = ref.watch(upcomingMoviesProvider);
    final topRated = ref.watch(topRatedMoviesProvider);
    final authUser = ref.watch(authStateProvider).valueOrNull;

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surfaceDark2,
        onRefresh: () async {
          ref.invalidate(trendingMoviesProvider);
          ref.invalidate(popularMoviesProvider);
          ref.invalidate(upcomingMoviesProvider);
          ref.invalidate(topRatedMoviesProvider);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.bgDark,
              title: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.movie_creation_rounded,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Text('CineWave',
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () => context.go(AppRoutes.profile),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: authUser != null
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.surfaceDark2,
                      border: Border.all(
                        color: authUser != null
                            ? AppColors.primary
                            : AppColors.borderDark,
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      authUser != null
                          ? Icons.person_rounded
                          : Icons.person_outline_rounded,
                      size: 20,
                      color: authUser != null
                          ? AppColors.primary
                          : AppColors.textMutedDark,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FeaturedCarousel(
                    moviesAsync: trending,
                    onMovieTap: (m) => _goToDetail(context, m),
                  ),
                  const SizedBox(height: 24),
                  SectionHeader(
                    title: 'Popular Now',
                    onSeeAll: () => context.push(
                        AppRoutes.movieListPath(MovieCategory.popular.slug)),
                  ),
                  HorizontalMovieList(
                    moviesAsync: popular,
                    onMovieTap: (m) => _goToDetail(context, m),
                    onRetry: () => ref.invalidate(popularMoviesProvider),
                  ),
                  const SizedBox(height: 24),
                  SectionHeader(
                    title: 'Coming Soon',
                    onSeeAll: () => context.push(
                        AppRoutes.movieListPath(MovieCategory.upcoming.slug)),
                  ),
                  HorizontalMovieList(
                    moviesAsync: upcoming,
                    onMovieTap: (m) => _goToDetail(context, m),
                    onRetry: () => ref.invalidate(upcomingMoviesProvider),
                  ),
                  const SizedBox(height: 24),
                  SectionHeader(
                    title: 'Top Rated',
                    onSeeAll: () => context.push(
                        AppRoutes.movieListPath(MovieCategory.topRated.slug)),
                  ),
                  HorizontalMovieList(
                    moviesAsync: topRated,
                    onMovieTap: (m) => _goToDetail(context, m),
                    onRetry: () => ref.invalidate(topRatedMoviesProvider),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

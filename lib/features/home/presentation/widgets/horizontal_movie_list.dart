import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie.dart';
import 'movie_card.dart';
import 'movie_list_shimmer.dart';

class HorizontalMovieList extends StatelessWidget {
  final AsyncValue<List<Movie>> moviesAsync;
  final void Function(Movie movie)? onMovieTap;
  final VoidCallback? onRetry;

  const HorizontalMovieList({
    super.key,
    required this.moviesAsync,
    this.onMovieTap,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 250,
      child: moviesAsync.when(
        loading: () => const MovieListShimmer(),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded,
                  size: 36, color: AppColors.textMutedDark),
              const SizedBox(height: 10),
              Text('Failed to load',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textMutedDark)),
              if (onRetry != null) ...[
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('Retry'),
                  style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary),
                ),
              ],
            ],
          ),
        ),
        data: (movies) {
          if (movies.isEmpty) {
            return Center(
              child: Text('No movies',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textMutedDark)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                movie: movie,
                onTap: onMovieTap != null ? () => onMovieTap!(movie) : null,
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../providers/movie_detail_providers.dart';
import '../widgets/action_buttons.dart';
import '../widgets/cast_list.dart';
import '../widgets/detail_sliver_app_bar.dart';
import '../widgets/genre_chips.dart';
import '../widgets/similar_movies_section.dart';

class MovieDetailPage extends ConsumerWidget {
  final int movieId;
  final Movie? initial;

  const MovieDetailPage({
    super.key,
    required this.movieId,
    this.initial,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(movieDetailProvider(movieId));
    final creditsAsync = ref.watch(movieCreditsProvider(movieId));
    final textTheme = Theme.of(context).textTheme;

    final detail = detailAsync.valueOrNull;

    final headerTitle = detail?.title ?? initial?.title ?? '';
    final headerRating = detail?.formattedRating ?? initial?.formattedRating ?? '';
    final headerYear = detail?.year ?? initial?.year ?? '';
    final headerBackdrop = detail?.backdropPath.isNotEmpty == true
        ? detail!.backdropPath
        : initial?.backdropPath;
    final headerPoster = detail?.posterPath.isNotEmpty == true
        ? detail!.posterPath
        : initial?.posterPath;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailSliverAppBar(
            movieId: movieId,
            backdropPath: headerBackdrop,
            posterPath: headerPoster,
            title: headerTitle,
            rating: headerRating,
            year: headerYear,
          ),
          SliverToBoxAdapter(
            child: detailAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Failed to load movie', style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text('$e', style: textTheme.bodySmall),
                  ],
                ),
              ),
              data: (detail) => Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (detail.tagline.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          detail.tagline,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryDark,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _MetaRow(detail: detail),
                    ),
                    const SizedBox(height: 20),
                    ActionButtons(
                      movieId: movieId,
                      movie: Movie(
                        id: detail.id,
                        title: detail.title,
                        posterPath: detail.posterPath,
                        backdropPath: detail.backdropPath,
                        overview: detail.overview,
                        voteAverage: detail.voteAverage,
                        releaseDate: detail.releaseDate,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GenreChips(genres: detail.genres),
                    if (detail.overview.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Overview', style: textTheme.titleLarge),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          detail.overview,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryDark,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Cast', style: textTheme.titleLarge),
                    ),
                    const SizedBox(height: 12),
                    CastList(castAsync: creditsAsync),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                          Text('Similar Movies', style: textTheme.titleLarge),
                    ),
                    const SizedBox(height: 12),
                    SimilarMoviesSection(movieId: movieId),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final MovieDetail detail;
  const _MetaRow({required this.detail});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final parts = <Widget>[];

    if (detail.formattedRuntime.isNotEmpty) {
      parts.add(Text(detail.formattedRuntime, style: textTheme.bodyMedium));
    }
    if (detail.originalLanguage.isNotEmpty) {
      if (parts.isNotEmpty) parts.add(_dot());
      parts.add(Text(
        detail.originalLanguage.toUpperCase(),
        style: textTheme.bodyMedium,
      ));
    }
    if (detail.status.isNotEmpty) {
      if (parts.isNotEmpty) parts.add(_dot());
      parts.add(Text(detail.status, style: textTheme.bodyMedium));
    }

    if (parts.isEmpty) return const SizedBox.shrink();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: parts,
    );
  }

  Widget _dot() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text('·', style: TextStyle(color: AppColors.textMutedDark)),
      );
}

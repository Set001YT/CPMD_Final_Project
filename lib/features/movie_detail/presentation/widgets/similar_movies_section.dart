import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../home/presentation/widgets/horizontal_movie_list.dart';
import '../providers/movie_detail_providers.dart';

class SimilarMoviesSection extends ConsumerWidget {
  final int movieId;
  const SimilarMoviesSection({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarAsync = ref.watch(similarMoviesProvider(movieId));
    return HorizontalMovieList(
      moviesAsync: similarAsync,
      onMovieTap: (movie) =>
          context.push(AppRoutes.movieDetailPath(movie.id), extra: movie),
    );
  }
}

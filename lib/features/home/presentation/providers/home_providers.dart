import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/get_trending_movies.dart';
import '../../domain/usecases/get_upcoming_movies.dart';

final trendingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final useCase = ref.watch(getTrendingMoviesProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (movies) => movies,
  );
});

final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final useCase = ref.watch(getPopularMoviesProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (movies) => movies,
  );
});

final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final useCase = ref.watch(getUpcomingMoviesProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (movies) => movies,
  );
});

final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final useCase = ref.watch(getTopRatedMoviesProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (movies) => movies,
  );
});

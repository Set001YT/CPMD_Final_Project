import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/detail_usecases.dart';

final movieDetailProvider =
    FutureProvider.family<MovieDetail, int>((ref, id) async {
  final useCase = ref.watch(getMovieDetailProvider);
  final result = await useCase(id);
  return result.fold((f) => throw Exception(f.message), (d) => d);
});

final movieCreditsProvider =
    FutureProvider.family<List<Cast>, int>((ref, id) async {
  final useCase = ref.watch(getMovieCreditsProvider);
  final result = await useCase(id);
  return result.fold((f) => throw Exception(f.message), (c) => c);
});

final movieVideosProvider =
    FutureProvider.family<List<Video>, int>((ref, id) async {
  final useCase = ref.watch(getMovieVideosProvider);
  final result = await useCase(id);
  return result.fold((f) => throw Exception(f.message), (v) => v);
});

final similarMoviesProvider =
    FutureProvider.family<List<Movie>, int>((ref, id) async {
  final useCase = ref.watch(getSimilarMoviesProvider);
  final result = await useCase(id);
  return result.fold((f) => throw Exception(f.message), (m) => m);
});

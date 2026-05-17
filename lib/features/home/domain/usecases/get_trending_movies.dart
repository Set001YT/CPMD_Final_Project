import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../entities/movie.dart';
import '../repositories/home_repository.dart';

class GetTrendingMovies {
  final HomeRepository repository;
  GetTrendingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call({int page = 1}) =>
      repository.getTrendingMovies(page: page);
}

final getTrendingMoviesProvider = Provider<GetTrendingMovies>((ref) {
  return GetTrendingMovies(ref.watch(homeRepositoryProvider));
});

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../entities/movie.dart';
import '../repositories/home_repository.dart';

class GetPopularMovies {
  final HomeRepository repository;
  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call({int page = 1}) =>
      repository.getPopularMovies(page: page);
}

final getPopularMoviesProvider = Provider<GetPopularMovies>((ref) {
  return GetPopularMovies(ref.watch(homeRepositoryProvider));
});

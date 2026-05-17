import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../entities/movie.dart';
import '../repositories/home_repository.dart';

class GetUpcomingMovies {
  final HomeRepository repository;
  GetUpcomingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call({int page = 1}) =>
      repository.getUpcomingMovies(page: page);
}

final getUpcomingMoviesProvider = Provider<GetUpcomingMovies>((ref) {
  return GetUpcomingMovies(ref.watch(homeRepositoryProvider));
});

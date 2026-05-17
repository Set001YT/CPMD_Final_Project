import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../entities/movie.dart';
import '../repositories/home_repository.dart';

class GetTopRatedMovies {
  final HomeRepository repository;
  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call({int page = 1}) =>
      repository.getTopRatedMovies(page: page);
}

final getTopRatedMoviesProvider = Provider<GetTopRatedMovies>((ref) {
  return GetTopRatedMovies(ref.watch(homeRepositoryProvider));
});

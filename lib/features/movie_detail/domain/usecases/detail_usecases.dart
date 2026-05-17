import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/movie.dart';
import '../../data/repositories/movie_detail_repository_impl.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieDetail {
  final MovieDetailRepository repository;
  GetMovieDetail(this.repository);
  Future<Either<Failure, MovieDetail>> call(int id) => repository.getDetail(id);
}

class GetMovieCredits {
  final MovieDetailRepository repository;
  GetMovieCredits(this.repository);
  Future<Either<Failure, List<Cast>>> call(int id) => repository.getCredits(id);
}

class GetMovieVideos {
  final MovieDetailRepository repository;
  GetMovieVideos(this.repository);
  Future<Either<Failure, List<Video>>> call(int id) => repository.getVideos(id);
}

class GetSimilarMovies {
  final MovieDetailRepository repository;
  GetSimilarMovies(this.repository);
  Future<Either<Failure, List<Movie>>> call(int id) =>
      repository.getSimilar(id);
}

final getMovieDetailProvider = Provider<GetMovieDetail>(
    (ref) => GetMovieDetail(ref.watch(movieDetailRepositoryProvider)));

final getMovieCreditsProvider = Provider<GetMovieCredits>(
    (ref) => GetMovieCredits(ref.watch(movieDetailRepositoryProvider)));

final getMovieVideosProvider = Provider<GetMovieVideos>(
    (ref) => GetMovieVideos(ref.watch(movieDetailRepositoryProvider)));

final getSimilarMoviesProvider = Provider<GetSimilarMovies>(
    (ref) => GetSimilarMovies(ref.watch(movieDetailRepositoryProvider)));

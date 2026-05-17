import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../home/domain/entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieDetailRepository {
  Future<Either<Failure, MovieDetail>> getDetail(int id);
  Future<Either<Failure, List<Cast>>> getCredits(int id);
  Future<Either<Failure, List<Video>>> getVideos(int id);
  Future<Either<Failure, List<Movie>>> getSimilar(int id);
}

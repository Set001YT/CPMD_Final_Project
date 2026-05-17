import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/chopper_provider.dart';
import '../../../home/data/models/movie_response_dto.dart';
import '../../../home/data/services/movie_api_service.dart';
import '../../../home/domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_detail_repository.dart';
import '../models/credits_dto.dart';
import '../models/movie_detail_dto.dart';
import '../models/video_response_dto.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieApiService apiService;
  MovieDetailRepositoryImpl(this.apiService);

  Future<Either<Failure, T>> _safeCall<T>(
    Future<Response<dynamic>> Function() apiCall,
    T Function(Map<String, dynamic>) parser,
  ) async {
    try {
      final response = await apiCall();
      if (response.isSuccessful && response.body != null) {
        final body = response.body as Map<String, dynamic>;
        return Right(parser(body));
      }
      return Left(ServerFailure('Server returned ${response.statusCode}'));
    } on SocketException {
      return const Left(NetworkFailure('No internet connection'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getDetail(int id) {
    return _safeCall(
      () => apiService.getDetail(id),
      (json) => MovieDetailDto.fromJson(json).toEntity(),
    );
  }

  @override
  Future<Either<Failure, List<Cast>>> getCredits(int id) {
    return _safeCall(
      () => apiService.getCredits(id),
      (json) => CreditsDto.fromJson(json)
          .cast
          .map((c) => c.toEntity())
          .toList(),
    );
  }

  @override
  Future<Either<Failure, List<Video>>> getVideos(int id) {
    return _safeCall(
      () => apiService.getVideos(id),
      (json) => VideoResponseDto.fromJson(json)
          .results
          .map((v) => v.toEntity())
          .toList(),
    );
  }

  @override
  Future<Either<Failure, List<Movie>>> getSimilar(int id) {
    return _safeCall(
      () => apiService.getSimilar(id),
      (json) => MovieResponseDto.fromJson(json)
          .results
          .map((m) => m.toEntity())
          .toList(),
    );
  }
}

final movieDetailRepositoryProvider = Provider<MovieDetailRepository>((ref) {
  final apiService = ref.watch(movieApiServiceProvider);
  return MovieDetailRepositoryImpl(apiService);
});

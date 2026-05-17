import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/chopper_provider.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/movie_response_dto.dart';
import '../services/movie_api_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final MovieApiService apiService;
  HomeRepositoryImpl(this.apiService);

  Future<Either<Failure, List<Movie>>> _fetch(
    Future<Response<dynamic>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      if (response.isSuccessful && response.body != null) {
        final body = response.body as Map<String, dynamic>;
        final dto = MovieResponseDto.fromJson(body);
        return Right(dto.results.map((m) => m.toEntity()).toList());
      }
      return Left(ServerFailure('Server returned ${response.statusCode}'));
    } on SocketException {
      return const Left(NetworkFailure('No internet connection'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies({int page = 1}) =>
      _fetch(() => apiService.getTrending(page: page));

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1}) =>
      _fetch(() => apiService.getPopular(page: page));

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies({int page = 1}) =>
      _fetch(() => apiService.getUpcoming(page: page));

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1}) =>
      _fetch(() => apiService.getTopRated(page: page));
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final apiService = ref.watch(movieApiServiceProvider);
  return HomeRepositoryImpl(apiService);
});

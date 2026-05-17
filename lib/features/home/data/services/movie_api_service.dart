import 'package:chopper/chopper.dart';

part 'movie_api_service.chopper.dart';

@ChopperApi()
abstract class MovieApiService extends ChopperService {
  static MovieApiService create([ChopperClient? client]) =>
      _$MovieApiService(client);

  @GET(path: '/trending/movie/week')
  Future<Response<dynamic>> getTrending({@Query('page') int page = 1});

  @GET(path: '/movie/popular')
  Future<Response<dynamic>> getPopular({@Query('page') int page = 1});

  @GET(path: '/movie/upcoming')
  Future<Response<dynamic>> getUpcoming({@Query('page') int page = 1});

  @GET(path: '/movie/top_rated')
  Future<Response<dynamic>> getTopRated({@Query('page') int page = 1});

  @GET(path: '/movie/{id}')
  Future<Response<dynamic>> getDetail(@Path('id') int id);

  @GET(path: '/movie/{id}/credits')
  Future<Response<dynamic>> getCredits(@Path('id') int id);

  @GET(path: '/movie/{id}/videos')
  Future<Response<dynamic>> getVideos(@Path('id') int id);

  @GET(path: '/movie/{id}/similar')
  Future<Response<dynamic>> getSimilar(
    @Path('id') int id, {
    @Query('page') int page = 1,
  });

  @GET(path: '/search/movie')
  Future<Response<dynamic>> searchMovies(
    @Query('query') String query, {
    @Query('page') int page = 1,
  });
}

import '../../../home/domain/entities/movie.dart';

abstract class FavoritesRepository {
  Stream<List<Movie>> watchFavorites();
  Future<List<Movie>> getFavorites();
  Stream<bool> watchIsFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
  Future<void> addFavorite(Movie movie);
  Future<void> removeFavorite(int movieId);
  Future<void> toggleFavorite(Movie movie);
  Future<void> clearAll();
}

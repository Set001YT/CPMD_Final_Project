import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/app_database.dart';
import '../../../../database/favorites_dao.dart';
import '../../../../database/database_providers.dart';
import '../../../home/domain/entities/movie.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDao _dao;

  FavoritesRepositoryImpl(this._dao);

  Movie _toMovie(FavoriteMovie row) {
    return Movie(
      id: row.movieId,
      title: row.title,
      posterPath: row.posterPath,
      backdropPath: row.backdropPath,
      overview: row.overview,
      voteAverage: row.voteAverage,
      releaseDate:
          row.releaseDate.isEmpty ? null : DateTime.tryParse(row.releaseDate),
    );
  }

  FavoriteMoviesCompanion _toCompanion(Movie movie) {
    return FavoriteMoviesCompanion(
      movieId: Value(movie.id),
      title: Value(movie.title),
      posterPath: Value(movie.posterPath),
      backdropPath: Value(movie.backdropPath),
      voteAverage: Value(movie.voteAverage),
      releaseDate: Value(
        movie.releaseDate != null
            ? movie.releaseDate!.toIso8601String().substring(0, 10)
            : '',
      ),
      overview: Value(movie.overview),
    );
  }

  @override
  Stream<List<Movie>> watchFavorites() {
    return _dao.watchAll().map((rows) => rows.map(_toMovie).toList());
  }

  @override
  Future<List<Movie>> getFavorites() async {
    final rows = await _dao.getAll();
    return rows.map(_toMovie).toList();
  }

  @override
  Stream<bool> watchIsFavorite(int movieId) => _dao.watchIsFavorite(movieId);

  @override
  Future<bool> isFavorite(int movieId) => _dao.isFavorite(movieId);

  @override
  Future<void> addFavorite(Movie movie) => _dao.add(_toCompanion(movie));

  @override
  Future<void> removeFavorite(int movieId) => _dao.remove(movieId);

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final already = await _dao.isFavorite(movie.id);
    if (already) {
      await _dao.remove(movie.id);
    } else {
      await _dao.add(_toCompanion(movie));
    }
  }

  @override
  Future<void> clearAll() => _dao.clear();
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final dao = ref.watch(favoritesDaoProvider);
  return FavoritesRepositoryImpl(dao);
});

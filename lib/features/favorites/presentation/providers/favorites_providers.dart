import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie.dart';
import '../../data/repositories/favorites_repository_impl.dart';

final favoritesStreamProvider = StreamProvider<List<Movie>>((ref) {
  return ref.watch(favoritesRepositoryProvider).watchFavorites();
});

final isFavoriteProvider =
    StreamProvider.family<bool, int>((ref, movieId) {
  return ref.watch(favoritesRepositoryProvider).watchIsFavorite(movieId);
});

final favoritesControllerProvider =
    Provider<FavoritesController>((ref) {
  return FavoritesController(ref);
});

class FavoritesController {
  final Ref _ref;
  FavoritesController(this._ref);

  Future<void> toggle(Movie movie) {
    return _ref.read(favoritesRepositoryProvider).toggleFavorite(movie);
  }

  Future<void> remove(int movieId) {
    return _ref.read(favoritesRepositoryProvider).removeFavorite(movieId);
  }

  Future<void> clearAll() {
    return _ref.read(favoritesRepositoryProvider).clearAll();
  }
}

import 'package:drift/drift.dart';

import 'app_database.dart';
import 'favorites_table.dart';

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [FavoriteMovies])
class FavoritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  Stream<List<FavoriteMovie>> watchAll() {
    return (select(favoriteMovies)
          ..orderBy([
            (t) => OrderingTerm(expression: t.savedAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<FavoriteMovie>> getAll() {
    return (select(favoriteMovies)
          ..orderBy([
            (t) => OrderingTerm(expression: t.savedAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Stream<bool> watchIsFavorite(int movieId) {
    return (select(favoriteMovies)..where((t) => t.movieId.equals(movieId)))
        .watchSingleOrNull()
        .map((row) => row != null);
  }

  Future<bool> isFavorite(int movieId) async {
    final row = await (select(favoriteMovies)
          ..where((t) => t.movieId.equals(movieId)))
        .getSingleOrNull();
    return row != null;
  }

  Future<void> add(FavoriteMoviesCompanion entry) {
    return into(favoriteMovies).insertOnConflictUpdate(entry);
  }

  Future<void> remove(int movieId) {
    return (delete(favoriteMovies)..where((t) => t.movieId.equals(movieId)))
        .go();
  }

  Future<void> clear() {
    return delete(favoriteMovies).go();
  }
}

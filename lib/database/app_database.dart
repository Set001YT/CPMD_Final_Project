import 'package:drift/drift.dart';

import 'connection/connection.dart'
    if (dart.library.html) 'connection/connection.web.dart';
import 'favorites_table.dart';
import 'favorites_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [FavoriteMovies],
  daos: [FavoritesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDriftDatabase());

  @override
  int get schemaVersion => 1;
}

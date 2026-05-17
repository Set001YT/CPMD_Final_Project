import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'favorites_dao.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final favoritesDaoProvider = Provider<FavoritesDao>((ref) {
  return ref.watch(appDatabaseProvider).favoritesDao;
});

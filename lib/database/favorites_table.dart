import 'package:drift/drift.dart';

@DataClassName('FavoriteMovie')
class FavoriteMovies extends Table {
  IntColumn get movieId => integer()();
  TextColumn get title => text()();
  TextColumn get posterPath => text().withDefault(const Constant(''))();
  TextColumn get backdropPath => text().withDefault(const Constant(''))();
  RealColumn get voteAverage => real().withDefault(const Constant(0))();
  TextColumn get releaseDate => text().withDefault(const Constant(''))();
  TextColumn get overview => text().withDefault(const Constant(''))();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {movieId};
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoriteMoviesTable extends FavoriteMovies
    with TableInfo<$FavoriteMoviesTable, FavoriteMovie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteMoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta = const VerificationMeta(
    'movieId',
  );
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
    'movie_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _backdropPathMeta = const VerificationMeta(
    'backdropPath',
  );
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
    'backdrop_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    movieId,
    title,
    posterPath,
    backdropPath,
    voteAverage,
    releaseDate,
    overview,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_movies';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteMovie> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(
        _movieIdMeta,
        movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
        _backdropPathMeta,
        backdropPath.isAcceptableOrUnknown(
          data['backdrop_path']!,
          _backdropPathMeta,
        ),
      );
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {movieId};
  @override
  FavoriteMovie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteMovie(
      movieId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}movie_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      )!,
      backdropPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backdrop_path'],
      )!,
      voteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vote_average'],
      )!,
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      )!,
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $FavoriteMoviesTable createAlias(String alias) {
    return $FavoriteMoviesTable(attachedDatabase, alias);
  }
}

class FavoriteMovie extends DataClass implements Insertable<FavoriteMovie> {
  final int movieId;
  final String title;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final DateTime savedAt;
  const FavoriteMovie({
    required this.movieId,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<int>(movieId);
    map['title'] = Variable<String>(title);
    map['poster_path'] = Variable<String>(posterPath);
    map['backdrop_path'] = Variable<String>(backdropPath);
    map['vote_average'] = Variable<double>(voteAverage);
    map['release_date'] = Variable<String>(releaseDate);
    map['overview'] = Variable<String>(overview);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  FavoriteMoviesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteMoviesCompanion(
      movieId: Value(movieId),
      title: Value(title),
      posterPath: Value(posterPath),
      backdropPath: Value(backdropPath),
      voteAverage: Value(voteAverage),
      releaseDate: Value(releaseDate),
      overview: Value(overview),
      savedAt: Value(savedAt),
    );
  }

  factory FavoriteMovie.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteMovie(
      movieId: serializer.fromJson<int>(json['movieId']),
      title: serializer.fromJson<String>(json['title']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      backdropPath: serializer.fromJson<String>(json['backdropPath']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      overview: serializer.fromJson<String>(json['overview']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<int>(movieId),
      'title': serializer.toJson<String>(title),
      'posterPath': serializer.toJson<String>(posterPath),
      'backdropPath': serializer.toJson<String>(backdropPath),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'overview': serializer.toJson<String>(overview),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  FavoriteMovie copyWith({
    int? movieId,
    String? title,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    String? releaseDate,
    String? overview,
    DateTime? savedAt,
  }) => FavoriteMovie(
    movieId: movieId ?? this.movieId,
    title: title ?? this.title,
    posterPath: posterPath ?? this.posterPath,
    backdropPath: backdropPath ?? this.backdropPath,
    voteAverage: voteAverage ?? this.voteAverage,
    releaseDate: releaseDate ?? this.releaseDate,
    overview: overview ?? this.overview,
    savedAt: savedAt ?? this.savedAt,
  );
  FavoriteMovie copyWithCompanion(FavoriteMoviesCompanion data) {
    return FavoriteMovie(
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      title: data.title.present ? data.title.value : this.title,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      voteAverage: data.voteAverage.present
          ? data.voteAverage.value
          : this.voteAverage,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      overview: data.overview.present ? data.overview.value : this.overview,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteMovie(')
          ..write('movieId: $movieId, ')
          ..write('title: $title, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('overview: $overview, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    movieId,
    title,
    posterPath,
    backdropPath,
    voteAverage,
    releaseDate,
    overview,
    savedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteMovie &&
          other.movieId == this.movieId &&
          other.title == this.title &&
          other.posterPath == this.posterPath &&
          other.backdropPath == this.backdropPath &&
          other.voteAverage == this.voteAverage &&
          other.releaseDate == this.releaseDate &&
          other.overview == this.overview &&
          other.savedAt == this.savedAt);
}

class FavoriteMoviesCompanion extends UpdateCompanion<FavoriteMovie> {
  final Value<int> movieId;
  final Value<String> title;
  final Value<String> posterPath;
  final Value<String> backdropPath;
  final Value<double> voteAverage;
  final Value<String> releaseDate;
  final Value<String> overview;
  final Value<DateTime> savedAt;
  const FavoriteMoviesCompanion({
    this.movieId = const Value.absent(),
    this.title = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.overview = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  FavoriteMoviesCompanion.insert({
    this.movieId = const Value.absent(),
    required String title,
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.overview = const Value.absent(),
    this.savedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<FavoriteMovie> custom({
    Expression<int>? movieId,
    Expression<String>? title,
    Expression<String>? posterPath,
    Expression<String>? backdropPath,
    Expression<double>? voteAverage,
    Expression<String>? releaseDate,
    Expression<String>? overview,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (title != null) 'title': title,
      if (posterPath != null) 'poster_path': posterPath,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (releaseDate != null) 'release_date': releaseDate,
      if (overview != null) 'overview': overview,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  FavoriteMoviesCompanion copyWith({
    Value<int>? movieId,
    Value<String>? title,
    Value<String>? posterPath,
    Value<String>? backdropPath,
    Value<double>? voteAverage,
    Value<String>? releaseDate,
    Value<String>? overview,
    Value<DateTime>? savedAt,
  }) {
    return FavoriteMoviesCompanion(
      movieId: movieId ?? this.movieId,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      overview: overview ?? this.overview,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteMoviesCompanion(')
          ..write('movieId: $movieId, ')
          ..write('title: $title, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('overview: $overview, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteMoviesTable favoriteMovies = $FavoriteMoviesTable(this);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteMovies];
}

typedef $$FavoriteMoviesTableCreateCompanionBuilder =
    FavoriteMoviesCompanion Function({
      Value<int> movieId,
      required String title,
      Value<String> posterPath,
      Value<String> backdropPath,
      Value<double> voteAverage,
      Value<String> releaseDate,
      Value<String> overview,
      Value<DateTime> savedAt,
    });
typedef $$FavoriteMoviesTableUpdateCompanionBuilder =
    FavoriteMoviesCompanion Function({
      Value<int> movieId,
      Value<String> title,
      Value<String> posterPath,
      Value<String> backdropPath,
      Value<double> voteAverage,
      Value<String> releaseDate,
      Value<String> overview,
      Value<DateTime> savedAt,
    });

class $$FavoriteMoviesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteMoviesTable> {
  $$FavoriteMoviesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get movieId => $composableBuilder(
    column: $table.movieId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteMoviesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteMoviesTable> {
  $$FavoriteMoviesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get movieId => $composableBuilder(
    column: $table.movieId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteMoviesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteMoviesTable> {
  $$FavoriteMoviesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get movieId =>
      $composableBuilder(column: $table.movieId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backdropPath => $composableBuilder(
    column: $table.backdropPath,
    builder: (column) => column,
  );

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$FavoriteMoviesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteMoviesTable,
          FavoriteMovie,
          $$FavoriteMoviesTableFilterComposer,
          $$FavoriteMoviesTableOrderingComposer,
          $$FavoriteMoviesTableAnnotationComposer,
          $$FavoriteMoviesTableCreateCompanionBuilder,
          $$FavoriteMoviesTableUpdateCompanionBuilder,
          (
            FavoriteMovie,
            BaseReferences<_$AppDatabase, $FavoriteMoviesTable, FavoriteMovie>,
          ),
          FavoriteMovie,
          PrefetchHooks Function()
        > {
  $$FavoriteMoviesTableTableManager(
    _$AppDatabase db,
    $FavoriteMoviesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteMoviesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteMoviesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteMoviesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> movieId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> posterPath = const Value.absent(),
                Value<String> backdropPath = const Value.absent(),
                Value<double> voteAverage = const Value.absent(),
                Value<String> releaseDate = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => FavoriteMoviesCompanion(
                movieId: movieId,
                title: title,
                posterPath: posterPath,
                backdropPath: backdropPath,
                voteAverage: voteAverage,
                releaseDate: releaseDate,
                overview: overview,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> movieId = const Value.absent(),
                required String title,
                Value<String> posterPath = const Value.absent(),
                Value<String> backdropPath = const Value.absent(),
                Value<double> voteAverage = const Value.absent(),
                Value<String> releaseDate = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => FavoriteMoviesCompanion.insert(
                movieId: movieId,
                title: title,
                posterPath: posterPath,
                backdropPath: backdropPath,
                voteAverage: voteAverage,
                releaseDate: releaseDate,
                overview: overview,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteMoviesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteMoviesTable,
      FavoriteMovie,
      $$FavoriteMoviesTableFilterComposer,
      $$FavoriteMoviesTableOrderingComposer,
      $$FavoriteMoviesTableAnnotationComposer,
      $$FavoriteMoviesTableCreateCompanionBuilder,
      $$FavoriteMoviesTableUpdateCompanionBuilder,
      (
        FavoriteMovie,
        BaseReferences<_$AppDatabase, $FavoriteMoviesTable, FavoriteMovie>,
      ),
      FavoriteMovie,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteMoviesTableTableManager get favoriteMovies =>
      $$FavoriteMoviesTableTableManager(_db, _db.favoriteMovies);
}

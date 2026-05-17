class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double voteAverage;
  final DateTime? releaseDate;
  final List<int> genreIds;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
    this.releaseDate,
    this.genreIds = const [],
  });

  String get year =>
      releaseDate != null ? releaseDate!.year.toString() : '';

  String get formattedRating => voteAverage.toStringAsFixed(1);
}

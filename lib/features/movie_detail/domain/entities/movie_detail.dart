class Genre {
  final int id;
  final String name;
  const Genre({required this.id, required this.name});
}

class Cast {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  const Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });
}

class Video {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final bool official;

  const Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    required this.official,
  });

  bool get isYoutubeTrailer =>
      site.toLowerCase() == 'youtube' && type.toLowerCase() == 'trailer';

  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';
}

class MovieDetail {
  final int id;
  final String title;
  final String tagline;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;
  final int runtime;
  final DateTime? releaseDate;
  final List<Genre> genres;
  final String status;
  final String originalLanguage;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.tagline,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.releaseDate,
    required this.genres,
    required this.status,
    required this.originalLanguage,
  });

  String get year =>
      releaseDate != null ? releaseDate!.year.toString() : '';

  String get formattedRating => voteAverage.toStringAsFixed(1);

  String get formattedRuntime {
    if (runtime <= 0) return '';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    if (hours == 0) return '${minutes}m';
    return '${hours}h ${minutes}m';
  }
}

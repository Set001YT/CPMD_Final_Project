import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto {
  final int id;
  final String title;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final String? overview;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  MovieDto({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.voteAverage,
    this.releaseDate,
    this.genreIds,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  Movie toEntity() => Movie(
        id: id,
        title: title,
        posterPath: posterPath ?? '',
        backdropPath: backdropPath ?? '',
        overview: overview ?? '',
        voteAverage: voteAverage ?? 0.0,
        releaseDate: (releaseDate != null && releaseDate!.isNotEmpty)
            ? DateTime.tryParse(releaseDate!)
            : null,
        genreIds: genreIds ?? const [],
      );
}

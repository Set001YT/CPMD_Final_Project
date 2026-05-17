import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_detail.dart';

part 'movie_detail_dto.g.dart';

@JsonSerializable()
class GenreDto {
  final int id;
  final String name;
  GenreDto({required this.id, required this.name});

  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      _$GenreDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);

  Genre toEntity() => Genre(id: id, name: name);
}

@JsonSerializable()
class MovieDetailDto {
  final int id;
  final String title;
  final String? tagline;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final int? runtime;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final List<GenreDto>? genres;
  final String? status;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  MovieDetailDto({
    required this.id,
    required this.title,
    this.tagline,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    this.releaseDate,
    this.genres,
    this.status,
    this.originalLanguage,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailDtoToJson(this);

  MovieDetail toEntity() => MovieDetail(
        id: id,
        title: title,
        tagline: tagline ?? '',
        overview: overview ?? '',
        posterPath: posterPath ?? '',
        backdropPath: backdropPath ?? '',
        voteAverage: voteAverage ?? 0.0,
        voteCount: voteCount ?? 0,
        runtime: runtime ?? 0,
        releaseDate: (releaseDate != null && releaseDate!.isNotEmpty)
            ? DateTime.tryParse(releaseDate!)
            : null,
        genres: (genres ?? []).map((g) => g.toEntity()).toList(),
        status: status ?? '',
        originalLanguage: originalLanguage ?? '',
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreDto _$GenreDtoFromJson(Map<String, dynamic> json) =>
    GenreDto(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$GenreDtoToJson(GenreDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

MovieDetailDto _$MovieDetailDtoFromJson(Map<String, dynamic> json) =>
    MovieDetailDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      runtime: (json['runtime'] as num?)?.toInt(),
      releaseDate: json['release_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      originalLanguage: json['original_language'] as String?,
    );

Map<String, dynamic> _$MovieDetailDtoToJson(MovieDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tagline': instance.tagline,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'runtime': instance.runtime,
      'release_date': instance.releaseDate,
      'genres': instance.genres,
      'status': instance.status,
      'original_language': instance.originalLanguage,
    };

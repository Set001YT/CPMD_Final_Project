// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDto _$MovieDtoFromJson(Map<String, dynamic> json) => MovieDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  overview: json['overview'] as String?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  releaseDate: json['release_date'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$MovieDtoToJson(MovieDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'poster_path': instance.posterPath,
  'backdrop_path': instance.backdropPath,
  'overview': instance.overview,
  'vote_average': instance.voteAverage,
  'release_date': instance.releaseDate,
  'genre_ids': instance.genreIds,
};

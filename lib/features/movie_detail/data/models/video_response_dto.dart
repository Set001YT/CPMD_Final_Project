import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_detail.dart';

part 'video_response_dto.g.dart';

@JsonSerializable()
class VideoDto {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final bool? official;

  VideoDto({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    this.official,
  });

  factory VideoDto.fromJson(Map<String, dynamic> json) =>
      _$VideoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDtoToJson(this);

  Video toEntity() => Video(
        id: id,
        key: key,
        name: name,
        site: site,
        type: type,
        official: official ?? false,
      );
}

@JsonSerializable()
class VideoResponseDto {
  final int id;
  final List<VideoDto> results;

  VideoResponseDto({required this.id, required this.results});

  factory VideoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VideoResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoResponseDtoToJson(this);
}

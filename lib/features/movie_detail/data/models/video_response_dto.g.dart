// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDto _$VideoDtoFromJson(Map<String, dynamic> json) => VideoDto(
  id: json['id'] as String,
  key: json['key'] as String,
  name: json['name'] as String,
  site: json['site'] as String,
  type: json['type'] as String,
  official: json['official'] as bool?,
);

Map<String, dynamic> _$VideoDtoToJson(VideoDto instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
  'name': instance.name,
  'site': instance.site,
  'type': instance.type,
  'official': instance.official,
};

VideoResponseDto _$VideoResponseDtoFromJson(Map<String, dynamic> json) =>
    VideoResponseDto(
      id: (json['id'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => VideoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoResponseDtoToJson(VideoResponseDto instance) =>
    <String, dynamic>{'id': instance.id, 'results': instance.results};

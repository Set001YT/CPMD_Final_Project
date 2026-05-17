// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastDto _$CastDtoFromJson(Map<String, dynamic> json) => CastDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  character: json['character'] as String?,
  profilePath: json['profile_path'] as String?,
);

Map<String, dynamic> _$CastDtoToJson(CastDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'character': instance.character,
  'profile_path': instance.profilePath,
};

CreditsDto _$CreditsDtoFromJson(Map<String, dynamic> json) => CreditsDto(
  id: (json['id'] as num).toInt(),
  cast: (json['cast'] as List<dynamic>)
      .map((e) => CastDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreditsDtoToJson(CreditsDto instance) =>
    <String, dynamic>{'id': instance.id, 'cast': instance.cast};

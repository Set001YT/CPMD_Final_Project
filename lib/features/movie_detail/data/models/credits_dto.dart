import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/movie_detail.dart';

part 'credits_dto.g.dart';

@JsonSerializable()
class CastDto {
  final int id;
  final String name;
  final String? character;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  CastDto({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
  });

  factory CastDto.fromJson(Map<String, dynamic> json) =>
      _$CastDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CastDtoToJson(this);

  Cast toEntity() => Cast(
        id: id,
        name: name,
        character: character ?? '',
        profilePath: profilePath ?? '',
      );
}

@JsonSerializable()
class CreditsDto {
  final int id;
  final List<CastDto> cast;

  CreditsDto({required this.id, required this.cast});

  factory CreditsDto.fromJson(Map<String, dynamic> json) =>
      _$CreditsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreditsDtoToJson(this);
}

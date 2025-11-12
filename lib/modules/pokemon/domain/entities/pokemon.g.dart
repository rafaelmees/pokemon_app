// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
  evolutions: json['evolutions'] == null
      ? null
      : Evolutions.fromJson(json['evolutions'] as Map<String, dynamic>),
  height: json['height'] as String,
  id: (json['id'] as num).toInt(),
  image: json['img'] as String,
  isFavorite: json['favorite'] as bool? ?? false,
  name: json['name'] as String,
  number: json['num'] as String,
  types: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
  weaknesses: (json['weaknesses'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  weight: json['weight'] as String,
);

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
  'evolutions': instance.evolutions?.toJson(),
  'height': instance.height,
  'id': instance.id,
  'img': instance.image,
  'favorite': instance.isFavorite,
  'name': instance.name,
  'num': instance.number,
  'type': instance.types,
  'weaknesses': instance.weaknesses,
  'weight': instance.weight,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolutions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evolutions _$EvolutionsFromJson(Map<String, dynamic> json) => Evolutions(
  previous: (json['previous'] as List<dynamic>)
      .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
      .toList(),
  next: (json['next'] as List<dynamic>)
      .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EvolutionsToJson(Evolutions instance) =>
    <String, dynamic>{
      'previous': instance.previous.map((e) => e.toJson()).toList(),
      'next': instance.next.map((e) => e.toJson()).toList(),
    };

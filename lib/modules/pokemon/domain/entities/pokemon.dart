import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/evolutions.dart';

part 'pokemon.g.dart';

@JsonSerializable(explicitToJson: true)
class Pokemon extends Equatable {
  const Pokemon({
    this.evolutions,
    required this.height,
    required this.id,
    required this.image,
    required this.name,
    required this.number,
    required this.types,
    required this.weaknesses,
    required this.weight,
  });

  @JsonKey(name: 'evolutions') 
  final Evolutions? evolutions;
  @JsonKey(name: 'height')
  final String height;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'img')
  final String image;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'num')
  final String number;
  @JsonKey(name: 'type')
  final List<String> types;
  @JsonKey(name: 'weaknesses')
  final List<String> weaknesses;
  @JsonKey(name: 'weight')
  final String weight;

  @override
  List<Object?> get props => <Object?>[
    id,
  ];

  // copyWith method
  Pokemon copyWith({
    Evolutions? evolutions,
    String? height,
    int? id,
    String? image,
    String? name,
    String? number,
    List<String>? types,
    List<String>? weaknesses,
    String? weight,
  }) {
    return Pokemon(
      evolutions: evolutions ?? this.evolutions,
      height: height ?? this.height,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      number: number ?? this.number,
      types: types ?? this.types,
      weaknesses: weaknesses ?? this.weaknesses,
      weight: weight ?? this.weight,
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

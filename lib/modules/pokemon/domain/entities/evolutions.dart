import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';

part 'evolutions.g.dart';

@JsonSerializable(explicitToJson: true)
class Evolutions {
  const Evolutions({
    required this.previous,
    required this.next,
  });

  @JsonKey(name: 'previous')
  final List<Pokemon> previous;
  @JsonKey(name: 'next')
  final List<Pokemon> next;

  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);

  factory Evolutions.fromJson(Map<String, dynamic> json) => _$EvolutionsFromJson(json);
}

part of 'bloc.dart';

class PokemonDetailEvent {
  const PokemonDetailEvent();
}

class PokemonDetailEventLoadPokemon extends PokemonDetailEvent {
  const PokemonDetailEventLoadPokemon({
    required this.pokemon,
  });

  final Pokemon pokemon;
}

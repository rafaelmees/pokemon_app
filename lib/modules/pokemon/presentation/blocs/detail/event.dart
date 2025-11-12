part of 'bloc.dart';

class PokemonDetailEvent {
  const PokemonDetailEvent();
}

class PokemonDetailEventToggleFavorite extends PokemonDetailEvent {
  const PokemonDetailEventToggleFavorite({
    required this.pokemon,
  });

  final Pokemon pokemon;
}

class PokemonDetailEventLoadPokemon extends PokemonDetailEvent {
  const PokemonDetailEventLoadPokemon({
    required this.pokemon,
  });

  final Pokemon pokemon;
}

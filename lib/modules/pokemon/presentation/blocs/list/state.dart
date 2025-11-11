part of 'bloc.dart';

class PokemonListState {
  const PokemonListState();
}

class PokemonListStateFailure extends PokemonListState {
  const PokemonListStateFailure({
    required this.failure,
  });

  final Failure failure;
}

class PokemonListStateLoading extends PokemonListState {
  const PokemonListStateLoading();
}

class PokemonListStateLoaded extends PokemonListState {
  const PokemonListStateLoaded({
    required this.pokemons,
  });

  final List<Pokemon> pokemons;
}

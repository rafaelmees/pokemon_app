part of 'bloc.dart';

class PokemonDetailState {
  const PokemonDetailState();
}

class PokemonDetailStateFailure extends PokemonDetailState {
  const PokemonDetailStateFailure({
    required this.failure,
  });

  final Failure failure;
}

class PokemonDetailStateInitial extends PokemonDetailState {
  const PokemonDetailStateInitial();
}

class PokemonDetailStateLoaded extends PokemonDetailState {
  const PokemonDetailStateLoaded({
    required this.pokemon,
    this.isLoading = false,
  });

  final Pokemon pokemon;
  final bool isLoading;

  PokemonDetailStateLoaded copyWith({
    Pokemon? pokemon,
    bool? isLoading,
  }) {
    return PokemonDetailStateLoaded(
      pokemon: pokemon ?? this.pokemon,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

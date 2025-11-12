import 'package:pokemon_app/modules/app/common/failure/failure.dart';

class PokemonGetPokemonFailure extends Failure {
  const PokemonGetPokemonFailure() : super(message: 'Failed to get Pokémon');
}

class PokemonGetPokemonsFailure extends Failure {
  const PokemonGetPokemonsFailure() : super(message: 'Failed to get Pokémons');
}

class PokemonSetFavoriteFailure extends Failure {
  const PokemonSetFavoriteFailure() : super(message: 'Failed to set favorite status for Pokémon');
}

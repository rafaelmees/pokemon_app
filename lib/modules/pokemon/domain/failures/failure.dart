import 'package:pokemon_app/modules/app/common/failure/failure.dart';

class PokemonGetPokemonFailure extends Failure {
  const PokemonGetPokemonFailure() : super(message: 'Failed to get pokemon');
}

class PokemonGetPokemonsFailure extends Failure {
  const PokemonGetPokemonsFailure() : super(message: 'Failed to get pokemons');
}

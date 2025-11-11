import 'package:dartz/dartz.dart';
import 'package:pokemon_app/modules/app/common/failure/failure.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/infra/repositories/repository.dart';

class GetPokemonsUsecase {
  Future<Either<Failure, List<Pokemon>>> call() async {
    return await PokemonRepository.getPokemons();
  }
}

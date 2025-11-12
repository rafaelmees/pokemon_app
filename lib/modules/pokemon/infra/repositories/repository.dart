import 'package:dartz/dartz.dart';
import 'package:pokemon_app/modules/app/common/failure/failure.dart';
import 'package:pokemon_app/modules/app/common/tracking/tracking.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/domain/failures/failure.dart';
import 'package:pokemon_app/modules/pokemon/external/datasource.dart';

class PokemonRepository {
  static Future<Either<Failure, Pokemon>> getPokemon(int id) async {
    try {
      Tracking.log(
        'Getting pokemon with',
        module: 'Pokemon',
        method: 'getPokemon',
        parameters: <String, dynamic>{
          'id': id,
        },
      );
      return Right<Failure, Pokemon>(await PokemonDatasource.getPokemon(id));
    } catch (error, stackTrace) {
      Tracking.error(
        'Error!',
        module: 'Pokemon',
        method: 'getPokemon',
        error: error,
        stackTrace: stackTrace,
      );
      if (error is Failure) {
        return Left<Failure, Pokemon>(error);
      }
      return Left<Failure, Pokemon>(PokemonGetPokemonFailure());
    }
  }

  static Future<Either<Failure, List<Pokemon>>> getPokemons() async {
    try {
      Tracking.log(
        'Getting pokemons',
        module: 'Pokemon',
        method: 'getPokemons',
      );
      return Right<Failure, List<Pokemon>>(await PokemonDatasource.getPokemons());
    } catch (error, stackTrace) {
      Tracking.error(
        'Error!',
        module: 'Pokemon',
        method: 'getPokemons',
        error: error,
        stackTrace: stackTrace,
      );
      if (error is Failure) {
        return Left<Failure, List<Pokemon>>(error);
      }
      return Left<Failure, List<Pokemon>>(PokemonGetPokemonsFailure());
    }
  }

  static Future<Either<Failure, void>> setFavorite({
    required int id,
    required bool isFavorite,
  }) async {
    try {
      Tracking.log(
        'Setting favorite status',
        module: 'Pokemon',
        method: 'setFavorite',
        parameters: <String, dynamic>{
          'id': id,
          'isFavorite': isFavorite,
        },
      );
      await PokemonDatasource.setFavorite(
        id: id,
        isFavorite: isFavorite,
      );
      return Right<Failure, void>(null);
    } catch (error, stackTrace) {
      Tracking.error(
        'Error!',
        module: 'Pokemon',
        method: 'setFavorite',
        error: error,
        stackTrace: stackTrace,
      );
      if (error is Failure) {
        return Left<Failure, void>(error);
      }
      return Left<Failure, void>(PokemonSetFavoriteFailure());
    }
  }
}

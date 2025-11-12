import 'package:dartz/dartz.dart';
import 'package:pokemon_app/modules/app/common/failure/failure.dart';
import 'package:pokemon_app/modules/pokemon/infra/repositories/repository.dart';

class SetFavoriteUsecase {
  Future<Either<Failure, void>> call({
    required int id,
    required bool isFavorite,
  }) async {
    return await PokemonRepository.setFavorite(
      id: id,
      isFavorite: isFavorite,
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pokemon_app/modules/app/common/failure/failure.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/domain/usecases/get_pokemons_usecase.dart';

part 'event.dart';
part 'state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState>{
  PokemonListBloc() : super(const PokemonListStateLoading()) {
    on<PokemonListEventLoadPokemons>(_onLoadPokemons);
  }

  Future<void> _onLoadPokemons(
    PokemonListEventLoadPokemons event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(const PokemonListStateLoading());

    await (GetPokemonsUsecase()()).then(
      (Either<Failure, List<Pokemon>> result) {
        result.fold(
          (Failure failure) {
            emit(
              PokemonListStateFailure(
                failure: failure,
              ),
            );
          },
          (List<Pokemon> pokemons) {
            emit(
              PokemonListStateLoaded(
                pokemons: pokemons,
              ),
            );
          },
        );
      },
    );
  }
}

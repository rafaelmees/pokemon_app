import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pokemon_app/modules/app/common/failure/failure.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/domain/usecases/get_pokemon_usecase.dart';

part 'event.dart';
part 'state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState>{
  PokemonDetailBloc() : super(const PokemonDetailStateInitial()) {
    on<PokemonDetailEventLoadPokemon>(_onLoadPokemon);
  }

  Future<void> _onLoadPokemon(
    PokemonDetailEventLoadPokemon event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(
      PokemonDetailStateLoaded(
        pokemon: event.pokemon,
        isLoading: true,
      ),
    );

    await (GetPokemonUsecase()(
      event.pokemon.id,
    )).then(
      (Either<Failure, Pokemon> result) {
        result.fold(
          (Failure failure) {
            emit(
              PokemonDetailStateFailure(
                failure: failure,
              ),
            );
          },
          (Pokemon pokemon) {
            emit(
              PokemonDetailStateLoaded(
                pokemon: pokemon,
                isLoading: false,
              ),
            );
          },
        );
      },
    );
  }
}

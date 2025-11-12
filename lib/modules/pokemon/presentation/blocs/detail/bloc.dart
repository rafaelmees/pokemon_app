import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pokemon_app/modules/app/common/failure/failure.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/domain/usecases/get_pokemon_usecase.dart';
import 'package:pokemon_app/modules/pokemon/domain/usecases/set_favorite_usecase.dart';

part 'event.dart';
part 'state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState>{
  PokemonDetailBloc() : super(const PokemonDetailStateInitial()) {
    on<PokemonDetailEventLoadPokemon>(_onLoadPokemon);
    on<PokemonDetailEventToggleFavorite>(_onToggleFavorite);
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

  Future<void> _onToggleFavorite(
    PokemonDetailEventToggleFavorite event,
    Emitter<PokemonDetailState> emit,
  ) async {
    if (state is PokemonDetailStateLoaded) {
      final PokemonDetailStateLoaded currentState = state as PokemonDetailStateLoaded;
      final bool isFavorite = !currentState.pokemon.isFavorite;

      final Pokemon updatedPokemon = currentState.pokemon.copyWith(
        isFavorite: isFavorite,
      );

      emit(
        PokemonDetailStateLoaded(
          pokemon: updatedPokemon,
        ),
      );

      await (SetFavoriteUsecase()(
        id: updatedPokemon.id,
        isFavorite: isFavorite,
      )).then(
        (Either<Failure, void> result) {
          result.fold(
            (Failure failure) {
              emit(
                PokemonDetailStateFailure(
                  failure: failure,
                ),
              );
              emit(
                PokemonDetailStateLoaded(
                  pokemon: updatedPokemon.copyWith(
                    isFavorite: !isFavorite,
                  ),
                ),
              );
            },
            (_) {},
          );
        },
      );
    }
  }
}

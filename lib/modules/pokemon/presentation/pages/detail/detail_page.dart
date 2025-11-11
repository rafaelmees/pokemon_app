import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/presentation/blocs/detail/bloc.dart';
import 'package:pokemon_app/modules/pokemon/presentation/pages/detail/widgets/detail_widget.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailBloc>(
      create: (BuildContext context) => PokemonDetailBloc()..add(
        PokemonDetailEventLoadPokemon(
          pokemon: pokemon,
        ),
      ),
      child: BlocConsumer<PokemonDetailBloc, PokemonDetailState>(
        listener: (BuildContext context, PokemonDetailState pokemonDetailState) {
          if (pokemonDetailState is PokemonDetailStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(pokemonDetailState.failure.message),
              ),
            );
            Navigator.of(context).pop();
          }
        },
        builder: (BuildContext context, PokemonDetailState pokemonDetailState) {
          return Scaffold(
            body: PokemonDetailWidget(
              pokemon: pokemonDetailState is PokemonDetailStateLoaded ? pokemonDetailState.pokemon : pokemon,
            ),
          );
        },
      ),
    );
  }
}

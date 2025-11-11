import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/modules/pokemon/presentation/blocs/list/bloc.dart';
import 'package:pokemon_app/modules/pokemon/presentation/pages/list/widget/list_widget.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({
    super.key,
  });

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonListBloc>(
      create: (BuildContext context) => PokemonListBloc()..add(const PokemonListEventLoadPokemons()),
      child: BlocConsumer<PokemonListBloc, PokemonListState>(
        listener: (BuildContext context, PokemonListState state) {
          if (state is PokemonListStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
              ),
            );
          }
        },
        builder: (BuildContext context, PokemonListState pokemonListState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pokédex'),
            ),
            body: pokemonListState is PokemonListStateLoaded ? PokemonListWidget(
              pokemons: pokemonListState.pokemons,
            ) : const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

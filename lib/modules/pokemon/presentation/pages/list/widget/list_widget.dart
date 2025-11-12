import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/modules/app/common/tracking/tracking.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/constants.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/presentation/blocs/list/bloc.dart';
import 'package:pokemon_app/modules/pokemon/presentation/pages/detail/detail_page.dart';
import 'package:pokemon_app/modules/pokemon/presentation/widgets/pokemon_card_widget.dart';

class PokemonListWidget extends StatefulWidget {
  const PokemonListWidget({
    super.key,
    required this.pokemons,
  });

  final List<Pokemon> pokemons;

  @override
  State<PokemonListWidget> createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  Timer? _debounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      final String q = _controller.text.toLowerCase().trim();
      setState(() {
        _searchQuery = q;
      });
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      if (_searchFocus.hasFocus) {
        _searchFocus.unfocus();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<Pokemon> filteredPokemons = widget.pokemons.where((Pokemon pokemon) {
      final String q = _searchQuery.toLowerCase().trim();
      return pokemon.name.toLowerCase().contains(q) ||
        int.tryParse(pokemon.number.toString())?.toString() == int.tryParse(q)?.toString();
    }).toList();
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing1),
                child: TextField(
                  controller: _controller,
                  focusNode: _searchFocus,
                  decoration: const InputDecoration(
                    labelText: 'Search Pokémon',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Pokémon name or number',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            ...filteredPokemons.isNotEmpty ? <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.spacing1),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppConstants.spacing1,
                    crossAxisSpacing: AppConstants.spacing1,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final Pokemon pokemon = filteredPokemons[index];
                      return PokemonCardWidget(
                        onTap: () {
                          Tracking.event(
                            name: 'pokemon_selected',
                            parameters: pokemon.toJson(),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PokemonDetailPage(
                                pokemon: pokemon,
                              ),
                            ),
                          ).then(
                            (_) {
                              BlocProvider.of<PokemonListBloc>(context).add(
                                const PokemonListEventLoadPokemons(),
                              );
                            }
                          );
                        },
                        pokemon: pokemon,
                      );
                    },
                    childCount: filteredPokemons.length,
                  ),
                ),
              ),
            ] : <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No Pokémon found',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
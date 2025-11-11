import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/constants.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/theme/theme.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/presentation/widgets/type_chip.dart';
import 'package:pokemon_app/modules/pokemon/presentation/widgets/pokemon_card_widget.dart';

class PokemonDetailWidget extends StatelessWidget {
  const PokemonDetailWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          pinned: true,
          backgroundColor: AppTheme.colorForType(
            pokemon.types.first,
          ),
          foregroundColor: AppTheme.colorForType(
            pokemon.types.first,
          ).computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
          titleSpacing: 0,
          title: Row(
            children: <Widget>[
              Text(
                pokemon.name,
                key: const Key('pokemon-name'),
              ),
              const SizedBox(width: AppConstants.spacing1),
              Text(
                <String>[
                  '#',
                  pokemon.number,
                ].join(''),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: (AppTheme.colorForType(
                    pokemon.types.first,
                  ).computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white).withValues(
                    alpha: 0.7,
                  ),
                ),
                key: const Key('pokemon-number'),
              ),
            ],
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: <Widget>[
                Positioned(
                  bottom: -250,
                  top: -50,
                  left: -50,
                  right: -50,
                  child: Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: SvgPicture.asset(
                      'assets/images/pokeball_background.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.white.withValues(
                          alpha: 0.1,
                        ),
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: -20,
                  top: -20,
                  child: SvgPicture.asset(
                    'assets/types/${pokemon.types.first.toLowerCase()}.svg',
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(
                        alpha: 0.5,
                      ),
                      BlendMode.modulate,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                    ),
                    child: Image.network(
                      pokemon.image,
                    ),
                  ),
                ),
                Positioned(
                  top: kToolbarHeight + AppConstants.spacing1,
                  left: AppConstants.spacing1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pokemon.types.map<Widget>(
                      (String type) => TypeChip(
                        backgroundColor: Colors.white.withValues(
                          alpha: 0.2,
                        ),
                        foregroundColor: AppTheme.colorForType(pokemon.types.first).computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white,
                        showIcon: false,
                        type: type,
                      ),
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacing2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Height: ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                        Text(
                          pokemon.height,
                          style: Theme.of(context).textTheme.titleMedium,
                          key: const Key('pokemon-height'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacing1),
                    Row(
                      children: <Widget>[
                        Text(
                          'Weight: ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                        Text(
                          pokemon.weight,
                          style: Theme.of(context).textTheme.titleMedium,
                          key: const Key('pokemon-weight'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacing1),
                    Row(
                      children: <Widget>[
                        Text(
                          'Weaknesses:',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacing1),
                        Wrap(
                          children: pokemon.weaknesses.map<Widget>(
                            (String type) => TypeChip(
                              type: type,
                              showText: false,
                            ),
                          ).toList(),
                        ),
                      ],
                    ),
                    if (pokemon.evolutions != null) ...<Widget>[
                      const SizedBox(height: AppConstants.spacing1),
                      Text(
                        'Evolutions:',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.8,
                          ),
                        ),
                        key: const Key('pokemon-evolutions'),
                      ),
                      const SizedBox(height: AppConstants.spacing1),
                      if (pokemon.evolutions!.previous.isNotEmpty) ...pokemon.evolutions!.previous.map<Widget>(
                        (Pokemon evolution) => Container(
                          height: 100,
                          padding: const EdgeInsets.only(bottom: AppConstants.spacing1),
                          child: PokemonCardWidget(
                            pokemon: evolution,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(bottom: AppConstants.spacing1),
                        child: PokemonCardWidget(
                          pokemon: pokemon,
                        ),
                        ),
                      if (pokemon.evolutions!.next.isNotEmpty) ...pokemon.evolutions!.next.map<Widget>(
                        (Pokemon evolution) => Container(
                          height: 100,
                          padding: const EdgeInsets.only(bottom: AppConstants.spacing1),
                          child: PokemonCardWidget(
                            pokemon: evolution,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
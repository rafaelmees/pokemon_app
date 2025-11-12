import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/constants.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/theme/theme.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';

class PokemonCardWidget extends StatelessWidget {
  const PokemonCardWidget({
    super.key,
    this.onTap,
    required this.pokemon,
  });

  final void Function()? onTap;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    Color cardColor = AppTheme.colorForType(pokemon.types.first);
    Color textColor = cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),
      ),
      child: Card(
        color: cardColor,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: 20,
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

              Positioned(
                right: AppConstants.spacing1,
                child: Text(
                  <String>[
                    '#',
                    pokemon.number,
                  ].join(),
                ),
              ),

              Positioned(
                left: AppConstants.spacing1,
                top: AppConstants.spacing1,
                child: Icon(
                  pokemon.isFavorite == true ? Icons.star : Icons.star_border,
                  color: textColor,
                ),
              ),

              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        pokemon.image,
                        errorBuilder: (BuildContext c, Object e, StackTrace? s) => Center(child: Icon(Icons.broken_image)),
                        loadingBuilder: (BuildContext c, Widget child, ImageChunkEvent? progress) {
                          if (progress == null) return child;
                          return Center(child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1) : null));
                        },
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacing1),
                    Text(
                      pokemon.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/evolutions.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/presentation/pages/detail/widgets/detail_widget.dart';

import '../../../../helpers/test_http_overrides.dart';

void main() {
  setUp(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  tearDown(() {
    HttpOverrides.global = null;
  });

  testWidgets('PokemonDetailWidget', (WidgetTester tester) async {
    final Pokemon pokemon = Pokemon(
      id: 4,
      number: '004',
      name: 'Charmander',
      image: 'http://www.serebii.net/pokemongo/pokemon/004.png',
      types: <String>['Fire'],
      height: '0.61 m',
      weight: '8.5 kg',
      weaknesses: <String>['Water', 'Ground', 'Rock'],
      evolutions: Evolutions(
        previous: <Pokemon>[],
        next: <Pokemon>[
          Pokemon(
            id: 5,
            number: '005',
            name: 'Charmeleon',
            image: 'http://www.serebii.net/pokemongo/pokemon/005.png',
            types: <String>['Fire'],
            height: '1.09 m',
            weight: '19.0 kg',
            weaknesses: <String>['Water', 'Ground', 'Rock'],
          ),
          Pokemon(
            id: 6,
            number: '006',
            name: 'Charizard',
            image: 'http://www.serebii.net/pokemongo/pokemon/006.png',
            types: <String>['Fire', 'Flying'],
            height: '1.70 m',
            weight: '90.5 kg',
            weaknesses: <String>['Water', 'Electric', 'Rock'],
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonDetailWidget(pokemon: pokemon),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('pokemon-name')), findsOneWidget);
    expect(find.text('Charmander'), findsWidgets);

    expect(find.byKey(const Key('pokemon-number')), findsOneWidget);
    expect(find.text('#004'), findsWidgets);

    expect(find.byKey(const Key('pokemon-height')), findsOneWidget);
    expect(find.text('0.61 m'), findsOneWidget);

    expect(find.byKey(const Key('pokemon-weight')), findsOneWidget);
    expect(find.text('8.5 kg'), findsOneWidget);

    expect(find.byKey(const Key('pokemon-evolutions')), findsOneWidget);
  });
}

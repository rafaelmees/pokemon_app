import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/presentation/pages/list/widget/list_widget.dart';

void main() {
  group('PokemonListWidget', () {
    final List<Pokemon> items = <Pokemon>[
      Pokemon(
        id: 1,
        number: '001',
        name: 'Bulbasaur',
        image: 'http://www.serebii.net/pokemongo/pokemon/001.png',
        types: <String>['Grass', 'Poison'],
        height: '0.71 m',
        weight: '6.9 kg',
        weaknesses: <String>['Fire', 'Ice', 'Flying', 'Psychic'],
      ),
      Pokemon(
        id: 4,
        number: '004',
        name: 'Charmander',
        image: 'http://www.serebii.net/pokemongo/pokemon/004.png',
        types: <String>['Fire'],
        height: '0.61 m',
        weight: '8.5 kg',
        weaknesses: <String>['Water', 'Ground', 'Rock'],
      ),
      Pokemon(
        id: 7,
        number: '007',
        name: 'Squirtle',
        image: 'http://www.serebii.net/pokemongo/pokemon/007.png',
        types: <String>['Water'],
        height: '0.51 m',
        weight: '9.0 kg',
        weaknesses: <String>['Electric', 'Grass'],
      ),
    ];

    testWidgets('renders grid and filters by search text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonListWidget(pokemons: items),
          ),
        ),
      );

      expect(find.text('Bulbasaur'), findsOneWidget);
      expect(find.text('Charmander'), findsOneWidget);
      expect(find.text('Squirtle'), findsOneWidget);

      final Finder searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);
      await tester.enterText(searchField, 'char');
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.text('Charmander'), findsOneWidget);
      expect(find.text('Bulbasaur'), findsNothing);
      expect(find.text('Squirtle'), findsNothing);
    });
  });
}

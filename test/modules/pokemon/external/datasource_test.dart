import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_app/modules/pokemon/external/datasource.dart';

void main() {
  late HttpServer server;
  late String urlBase;

  setUpAll(() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final int port = server.port;
    urlBase = 'http://localhost:$port/pokedex.json';

    PokemonDatasource.pokemonListUrl = urlBase;

    server.listen((HttpRequest request) {
      final String path = request.uri.path;
      if (path == '/pokedex.json') {
        final String responseJson = jsonEncode(
          <String, List<Map<String, Object>>>{
            'pokemon': <Map<String, Object>>[
              <String, Object>{
                'id': 1,
                'num': '001',
                'name': 'Bulbasaur',
                'img': 'http://www.serebii.net/pokemongo/pokemon/001.png',
                'type': <String>[
                  'Grass',
                  'Poison',
                ],
                'height': '0.71 m',
                'weight': '6.9 kg',
                'weaknesses': <String>[
                  'Fire',
                  'Ice',
                  'Flying',
                  'Psychic',
                ],
                'next_evolution': <Map<String, String>>[
                  <String, String>{
                    'num': '002',
                    'name': 'Ivysaur',
                  },
                  <String, String>{
                    'num': '003',
                    'name': 'Venusaur',
                  },
                ],
              },
              <String, Object>{
                'id': 4,
                'num': '004',
                'name': 'Charmander',
                'img': 'http://www.serebii.net/pokemongo/pokemon/004.png',
                'type': <String>[
                  'Fire',
                ],
                'height': '0.61 m',
                'weight': '8.5 kg',
                'weaknesses': <String>[
                  'Water',
                  'Ground',
                  'Rock',
                ],
                'next_evolution': <Map<String, String>>[
                  <String, String>{
                    'num': '005',
                    'name': 'Charmeleon',
                  },
                  <String, String>{
                    'num': '006',
                    'name': 'Charizard',
                  },
                ],
              },
            ],
          },
        );
        request.response.statusCode = 200;
        request.response.headers.contentType = ContentType.json;
        request.response.write(responseJson);
        request.response.close();
      } else {
        request.response.statusCode = 404;
        request.response.close();
      }
    });
  });

  tearDownAll(() async {
    await server.close(force: true);
  });

  test('getPokemons returns a list from local server', () async {
    final List<Pokemon> pokemons = await PokemonDatasource.getPokemons();
    expect(pokemons, isA<List<Pokemon>>());
    expect(pokemons.length, 2);
    expect(pokemons[0].name, 'Bulbasaur');
    expect(pokemons[1].id, 4);
  });

  test('getPokemon returns correct pokemon by id', () async {
    final Pokemon p = await PokemonDatasource.getPokemon(4);
    expect(p.name, 'Charmander');
    expect(p.types, contains('Fire'));
  });
}

import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/modules/pokemon/domain/entities/pokemon.dart';

class PokemonDatasource {
  static String pokemonListUrl = 'https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json';

  static http.Client client = http.Client();

  static Future<List<Map<String, dynamic>>> getPokemonListJson() async {
    final http.Response response = await client.get(Uri.parse(pokemonListUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> pokemonList = jsonData['pokemon'] ?? <dynamic>[];
      return pokemonList.cast<Map<String, dynamic>>();
    } else {
      throw http.ClientException('Failed to load pokémons', Uri.parse(pokemonListUrl));
    }
  }

  static Future<Pokemon> getPokemon(int id) async {
    final List<Map<String, dynamic>> pokemonList = await getPokemonListJson();

    final Map<String, dynamic>? pokemonJson = pokemonList.firstWhereOrNull(
      (Map<String, dynamic> json) => json['id'] == id,
    );

    if (pokemonJson != null) {
      List<Map<String, dynamic>> previousEvolutionsJson = <Map<String, dynamic>>[];
      List<Map<String, dynamic>> nextEvolutionsJson = <Map<String, dynamic>>[];
      for (Map<String, dynamic> evolution in pokemonJson['prev_evolution'] ?? <dynamic>[]) {
        final Map<String, dynamic>? evolutionJson = pokemonList.firstWhereOrNull(
          (Map<String, dynamic> json) => json['num'] == evolution['num'],
        );
        if (evolutionJson != null) {
          previousEvolutionsJson.add(evolutionJson);
        }
      }
      for (Map<String, dynamic> evolution in pokemonJson['next_evolution'] ?? <dynamic>[]) {
        final Map<String, dynamic>? evolutionJson = pokemonList.firstWhereOrNull(
          (Map<String, dynamic> json) => json['num'] == evolution['num'],
        );
        if (evolutionJson != null) {
          nextEvolutionsJson.add(evolutionJson);
        }
      }
      final Pokemon pokemon = Pokemon.fromJson(<String, dynamic>{
        ...pokemonJson,
        'evolutions': nextEvolutionsJson.isNotEmpty || previousEvolutionsJson.isNotEmpty ? <String, List<Map<String, dynamic>>>{
          'next': nextEvolutionsJson,
          'previous': previousEvolutionsJson,
        } : null,
      });
      return pokemon;
    } else {
      throw http.ClientException('Pokémon with id $id not found', Uri.parse(pokemonListUrl));
    }
  }

  static Future<List<Pokemon>> getPokemons() async {
    final List<Map<String, dynamic>> pokemonList = await getPokemonListJson();

    return pokemonList.map((Map<String, dynamic> json) => Pokemon.fromJson(json)).toList();
  }
}

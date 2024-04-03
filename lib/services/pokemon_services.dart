import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonServices {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  static Future<List<Pokemon>> fetchOriginalPokemon() async {
    final response = await http.get(Uri.parse('$baseUrl?limit=20'));
    if (response.statusCode == 200) {
      final List<Pokemon> pokemonList = [];
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];

      for (final pokemon in data) {
        final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
        if (pokemonResponse.statusCode == 200) {
          final Map<String, dynamic> pokemonData =
              jsonDecode(pokemonResponse.body);
          pokemonList.add(Pokemon.fromJson(pokemonData));
        }
      }
      return pokemonList;
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}

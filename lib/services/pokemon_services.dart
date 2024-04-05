import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_flutter_app/helpers/db_helper.dart';
import 'package:pokemon_flutter_app/models/stats.dart';

import '../models/pokemon.dart';

class PokemonServices {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  static Future<String> _fetchPokemonFlavorText(String id) async {
    final url = '$baseUrl-species/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['flavor_text_entries'];
      final Map<String, dynamic> flavorTextData = data[0];
      return flavorTextData['flavor_text'];
    } else {
      throw Exception('Failed to load flavor text for pokemon $id');
    }
  }

  static Future<List<Pokemon>> fetchEvolutions(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final List<Pokemon> pokemonList = [];
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['evolution_chain']['url'];

      for (final pokemon in data) {
        final Pokemon newPokemon = await fetchPokemon(pokemon['name']);
        pokemonList.add(newPokemon);
      }
      return pokemonList;
    } else {
      throw Exception('Failed to load evolution chain for pokemon $id');
    }
  }

  static Future<Pokemon> fetchPokemon(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final String flavorText = await _fetchPokemonFlavorText(id);
      return Pokemon.fromJson(jsonData)
        ..flavorText = flavorText.replaceAll('\n', ' ');
    } else {
      throw Exception('Failed to load Pokemon $id');
    }
  }

  static Future<List<Pokemon>> fetchOriginalPokemonFromDB() async {
    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query('pokemon', where: 'id <= ?', whereArgs: [1025]);

    List<Pokemon> pokemonList = [];
    for (var map in maps) {
      final statsMaps = await db
          .query('stats', where: 'pokemon_id = ?', whereArgs: [map['id']]);
      if (statsMaps.isNotEmpty) {
        final stats = Stats.fromMap(statsMaps.first);

        pokemonList.add(Pokemon(
          id: map['id'],
          name: map['name'],
          height: map['height'].toDouble(),
          weight: map['weight'].toDouble(),
          imageUrl: map['imageUrl'],
          spriteUrl: map['spriteUrl'],
          flavorText: map['flavorText'],
          types: map['types'].split(','),
          latestCryUrl: map['latestCryUrl'],
          mainColor: Color(int.parse('0xFF' + map['mainColor'])),
          stats: stats,
        ));
      }
    }
    return pokemonList;
  }

  static Future<List<Pokemon>> fetchOriginalPokemon() async {
    final response = await http.get(Uri.parse('$baseUrl?limit=10'));
    if (response.statusCode == 200) {
      final List<Pokemon> pokemonList = [];
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];

      for (final pokemon in data) {
        final Pokemon newPokemon = await fetchPokemon(pokemon['name']);
        if (newPokemon.id <= 151) {
          pokemonList.add(newPokemon);
        }
      }
      return pokemonList;
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}

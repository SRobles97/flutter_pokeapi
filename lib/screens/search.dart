import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/screens/pokedetails.dart';

import '../models/stats.dart';

class SearchScreen extends SearchDelegate<Pokemon> {
  final List<Pokemon> pokemonList;

  SearchScreen({required this.pokemonList});

  @override
  appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.red,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF9E2A2B),
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(fontSize: 24, fontFamily: 'VT323', color: Colors.white),
        displayMedium:
            TextStyle(fontSize: 20, fontFamily: 'VT323', color: Colors.white),
        displaySmall:
            TextStyle(fontSize: 16, fontFamily: 'VT323', color: Colors.white),
        bodyLarge:
            TextStyle(fontSize: 16, fontFamily: 'VT323', color: Colors.white),
        bodyMedium:
            TextStyle(fontSize: 14, fontFamily: 'VT323', color: Colors.white),
        bodySmall:
            TextStyle(fontSize: 12, fontFamily: 'VT323', color: Colors.white),
        titleLarge: TextStyle(
            fontSize: 28,
            fontFamily: 'VT323',
            color: Colors.white,
            fontWeight: FontWeight.w200,
            letterSpacing: 2),
        titleMedium:
            TextStyle(fontSize: 16, fontFamily: 'VT323', color: Colors.white),
        titleSmall:
            TextStyle(fontSize: 12, fontFamily: 'VT323', color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
            context,
            Pokemon(
              id: 0,
              name: '',
              height: 0,
              weight: 0,
              imageUrl: '',
              spriteUrl: '',
              types: [],
              latestCryUrl: '',
              mainColor: Colors.white,
              stats: Stats(
                  hp: 0,
                  attack: 0,
                  defense: 0,
                  specialAttack: 0,
                  specialDefense: 0,
                  speed: 0),
            ));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = query.isEmpty
        ? []
        : pokemonList
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(results[index].name),
            leading: Image.network(results[index].imageUrl),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PokeDetails(pokemon: results[index]),
                ),
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : pokemonList
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name),
          onTap: () {
            query = suggestions[index].name;
            showResults(context);
          },
        );
      },
    );
  }
}

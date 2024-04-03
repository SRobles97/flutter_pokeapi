import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/helpers/style_helper.dart';
import 'package:pokemon_flutter_app/screens/pokelist.dart';

void main() => runApp(ProviderScope(child: const PokemonApp()));

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: StyleHelper.theme,
      home: const PokeList(),
    );
  }
}

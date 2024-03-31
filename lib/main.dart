import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/screens/pokelist.dart';

void main() => runApp(ProviderScope(child: const PokemonApp()));

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontFamily: 'VT323'),
          displayMedium: TextStyle(fontSize: 20, fontFamily: 'VT323'),
          displaySmall: TextStyle(fontSize: 16, fontFamily: 'VT323'),
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
          titleMedium: TextStyle(fontSize: 16, fontFamily: 'VT323'),
          titleSmall: TextStyle(fontSize: 12, fontFamily: 'VT323'),
        ),
        useMaterial3: true,
      ),
      home: const PokeList(),
    );
  }
}

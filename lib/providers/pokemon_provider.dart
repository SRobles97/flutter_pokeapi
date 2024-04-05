import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/services/pokemon_services.dart';

import '../models/pokemon.dart';

class PokemonNotifier extends StateNotifier<List<Pokemon>> {
  PokemonNotifier() : super([]) {
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    final pokemon = await PokemonServices.fetchOriginalPokemonFromDB();
    state = pokemon;
  }

  void setPokemon(List<Pokemon> pokemon) {
    state = pokemon;
  }
}

final pokemonProvider =
    StateNotifierProvider<PokemonNotifier, List<Pokemon>>((ref) {
  return PokemonNotifier();
});

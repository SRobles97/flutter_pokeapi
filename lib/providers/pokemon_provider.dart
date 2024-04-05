import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/services/pokemon_services.dart';

class PokemonState {
  final List<Pokemon> pokemons;
  final int currentIndex;

  PokemonState({required this.pokemons, this.currentIndex = 0});

  Pokemon? get currentPokemon => (pokemons.isNotEmpty &&
          currentIndex >= 0 &&
          currentIndex < pokemons.length)
      ? pokemons[currentIndex]
      : null;

  bool get isFirstPokemon => currentIndex == 0;

  bool get isLastPokemon => currentIndex == pokemons.length - 1;

  PokemonState copyWith({List<Pokemon>? pokemons, int? currentIndex}) {
    return PokemonState(
      pokemons: pokemons ?? this.pokemons,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class PokemonNotifier extends StateNotifier<PokemonState> {
  PokemonNotifier() : super(PokemonState(pokemons: [])) {
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    final pokemons = await PokemonServices.fetchOriginalPokemonFromDB();
    state = PokemonState(pokemons: pokemons);
  }

  void setCurrentPokemon(int id) {
    final index = state.pokemons.indexWhere((pokemon) => pokemon.id == id);
    if (index != -1) {
      state = state.copyWith(currentIndex: index);
    }
  }

  void nextPokemon() {
    if (state.currentIndex < state.pokemons.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previousPokemon() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void setPokemon(List<Pokemon> pokemons) {
    state = PokemonState(pokemons: pokemons);
  }
}

final pokemonProvider =
    StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
  return PokemonNotifier();
});

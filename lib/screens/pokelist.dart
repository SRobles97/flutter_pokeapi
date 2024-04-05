import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/screens/search.dart';
import 'package:pokemon_flutter_app/widgets/poke_card.dart';

import '../providers/pokemon_provider.dart';

class PokeList extends ConsumerWidget {
  const PokeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    final pokemonState = ref.watch(pokemonProvider);

    if (pokemonState.pokemons.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('PokeList'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('PokeList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreen(
                  pokemonList: pokemonState.pokemons,
                  onSelectPokemon: (Pokemon pokemon) {
                    ref
                        .read(pokemonProvider.notifier)
                        .setCurrentPokemon(pokemon.id);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width < 600 ? 2 : 4,
        ),
        itemCount: pokemonState.pokemons.length,
        itemBuilder: (context, index) {
          return PokeCard(pokemon: pokemonState.pokemons[index]);
        },
      ),
    );
  }
}

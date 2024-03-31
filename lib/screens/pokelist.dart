import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/widgets/poke_card.dart';

import '../providers/pokemon_provider.dart';

class PokeList extends ConsumerWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonFuture = ref.watch(pokemonProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('PokeList'),
      ),
      body: pokemonFuture.when(
        data: (pokemonList) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              return PokeCard(pokemon: pokemonList[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

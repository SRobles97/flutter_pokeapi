import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_provider.dart';

class PokeList extends ConsumerWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonFuture = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeList'),
      ),
      body: pokemonFuture.when(
        data: (pokemonList) {
          return ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              return Card(
                color: pokemonList[index].mainColor,
                child: ListTile(
                  leading: Image.network(pokemonList[index].spriteUrl),
                  title: Text(pokemonList[index].name),
                  subtitle: Text(pokemonList[index].types.join(', ')),
                ),
              );
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

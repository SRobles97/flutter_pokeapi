import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/helpers/style_helper.dart';
import 'package:pokemon_flutter_app/helpers/types_helper.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/widgets/custom_appbar.dart';
import 'package:pokemon_flutter_app/widgets/stats_barchart.dart';
import 'package:pokemon_flutter_app/widgets/type_card.dart';

import '../providers/pokemon_provider.dart';

class PokeDetails extends ConsumerWidget {
  const PokeDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    final pokemonState = ref.watch(pokemonProvider);
    final Pokemon? pokemon = pokemonState.currentPokemon;
    final pokemonNotifier = ref.read(pokemonProvider.notifier);

    if (pokemon == null) {
      return const Scaffold(
        body: Center(child: Text('No Pokémon selected')),
      );
    }

    Widget typesRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: pokemon.types
            .map((type) => TypeCard(
                  type: type,
                  color: TypesHelper.getTypeColour(type),
                  displayLarge: true,
                ))
            .toList(),
      );
    }

    Widget measurementInfo(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Height',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                '${pokemon.height}m',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          const SizedBox(width: 25),
          Column(
            children: [
              Text(
                'Weight',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                '${pokemon.weight}kg',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ],
      );
    }

    Widget aboutTab() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: const EdgeInsets.all(20),
              child: Text(
                pokemon.flavorText ?? 'No description available',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Details',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                typesRow(),
                measurementInfo(context),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Evolution Chain',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      );
    }

    Widget statsTab() {
      var size = MediaQuery.of(context).size;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Base Stats',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: size.height * 0.4,
                child: StatsBarChart(
                    stats: pokemon.stats,
                    color: pokemon.mainColor.withAlpha(200))),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'TOTAL: ${pokemon.stats.total}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: StyleHelper.idStylized(pokemon.id.toString()),
          heroTag: pokemon.id,
          urlImage: pokemon.imageUrl,
          pokeName: pokemon.name,
          preferredSize: Size.fromHeight(size.height * 0.3),
          pokemonHeight: pokemon.height,
          pokemonWeight: pokemon.weight,
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onBackground,
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelStyle: Theme.of(context).textTheme.displayMedium,
                tabs: const [
                  Tab(text: 'About', icon: Icon(Icons.info)),
                  Tab(text: 'Stats', icon: Icon(Icons.bar_chart)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    aboutTab(),
                    statsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.1,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: pokemonState.isFirstPokemon
                    ? null
                    : () {
                        pokemonNotifier.previousPokemon();
                      },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: pokemonState.isLastPokemon
                    ? null
                    : () {
                        pokemonNotifier.nextPokemon();
                      },
              ),
            ],
          ),
        ));
  }
}

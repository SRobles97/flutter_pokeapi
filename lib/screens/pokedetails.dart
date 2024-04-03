import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemon_flutter_app/helpers/style_helper.dart';
import 'package:pokemon_flutter_app/helpers/types_helper.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/widgets/custom_appbar.dart';
import 'package:pokemon_flutter_app/widgets/stats_barchart.dart';
import 'package:pokemon_flutter_app/widgets/type_card.dart';

class PokeDetails extends StatelessWidget {
  final Pokemon pokemon;

  const PokeDetails({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: StyleHelper.idStylized(pokemon.id.toString()),
        heroTag: pokemon.id,
        urlImage: pokemon.imageUrl,
        pokeName: pokemon.name,
        preferredSize: Size.fromHeight(size.height * 0.3),
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
              unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
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
                  aboutTab(context),
                  statsTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget aboutTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              typesRow(),
              measurementInfo(context),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Description',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 10),
          Card(
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                pokemon.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statsTab(BuildContext context) {
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
              child:
                  StatsBarChart(stats: pokemon.stats, color: pokemon.mainColor))
        ],
      ),
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
              style: Theme.of(context).textTheme.displayLarge,
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
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ],
    );
  }
}

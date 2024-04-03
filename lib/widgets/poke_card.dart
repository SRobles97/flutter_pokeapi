import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/helpers/style_helper.dart';

import 'package:pokemon_flutter_app/helpers/types_helper.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/widgets/type_card.dart';

import '../screens/pokedetails.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokeCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokeDetails(pokemon: pokemon),
          ),
        );
      },
      child: Card(
        color: pokemon.mainColor.withOpacity(0.85),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  StyleHelper.idStylized(pokemon.id.toString()),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Hero(
                  tag: pokemon.id,
                  child: Image.network(
                    pokemon.imageUrl,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StyleHelper.firstLetterUppercased(pokemon.name),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: pokemon.types
                        .map((type) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: TypeCard(
                                  type: StyleHelper.firstLetterUppercased(type),
                                  color: TypesHelper.getTypeColour(type)),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Row(
                children: [
                  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.favorite_border,
                          color: Theme.of(context).colorScheme.primary)),
                  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.add_box_outlined,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

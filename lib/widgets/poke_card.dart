import 'package:flutter/material.dart';

import 'package:pokemon_flutter_app/helpers/types_helper.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/widgets/type_card.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokeCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    String _idStylized() {
      return '#${pokemon.id.toString().padLeft(3, '0')}';
    }

    String _firstLetterUppercase(String text) {
      return text[0].toUpperCase() + text.substring(1);
    }

    return Card(
      color: pokemon.mainColor.withOpacity(0.85),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _idStylized(),
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
              child: Image.network(
                pokemon.imageUrl,
                width: 120,
                height: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _firstLetterUppercase(pokemon.name),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Row(
                  children: pokemon.types
                      .map((type) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TypeCard(
                                type: _firstLetterUppercase(type),
                                color: TypesHelper.getTypeColour(type)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

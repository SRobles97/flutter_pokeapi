import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

enum PokemonSize { small, medium, large }

PokemonSize determinePokemonSize(double height, double weight) {
  const double heightLimitForMedium = 0.8;
  const double weightLimitForMedium = 25.0;
  const double heightLimitForLarge = 1.1;
  const double weightLimitForLarge = 40.0;

  if (height >= heightLimitForLarge && weight >= weightLimitForLarge) {
    return PokemonSize.large;
  } else if (height >= heightLimitForMedium && weight >= weightLimitForMedium) {
    return PokemonSize.medium;
  } else {
    return PokemonSize.small;
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final int heroTag;
  final String urlImage;
  final List<Widget> actions;
  final String pokeName;
  final double pokemonHeight;
  final double pokemonWeight;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.heroTag,
    required this.urlImage,
    required this.actions,
    required this.pokeName,
    required this.pokemonHeight,
    required this.pokemonWeight,
    this.preferredSize = const Size.fromHeight(300.0),
  });

  @override
  Widget build(BuildContext context) {
    String toUpper(String text) {
      return text.toUpperCase();
    }

    Widget pokemonArtwork() {
      PokemonSize size = determinePokemonSize(pokemonHeight, pokemonWeight);
      double width, height;
      switch (size) {
        case PokemonSize.small:
          width = height = 100;
          break;
        case PokemonSize.medium:
          width = height = 150;
          break;
        case PokemonSize.large:
          width = height = 200;
          break;
      }

      return Expanded(
        child: ClipRect(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.network(urlImage, fit: BoxFit.contain),
                      ));
                },
              );
            },
            child: FadeInImage.memoryNetwork(
              width: width,
              height: height,
              placeholder: kTransparentImage,
              image: urlImage,
            ),
          ),
        ),
      );
    }

    return AppBar(
      title: Text(title),
      actions: actions,
      centerTitle: false,
      flexibleSpace: Hero(
        tag: heroTag,
        child: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              pokemonArtwork(),
              Text(
                toUpper(pokeName),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 34,
                    ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

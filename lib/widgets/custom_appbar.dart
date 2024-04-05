import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final int heroTag;
  final String urlImage;
  final List<Widget> actions;
  final String pokeName;
  final double pokemonHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.heroTag,
    required this.urlImage,
    required this.actions,
    required this.pokeName,
    required this.pokemonHeight,
    this.preferredSize = const Size.fromHeight(300.0),
  });

  @override
  Widget build(BuildContext context) {
    String toUpper(String text) {
      return text.toUpperCase();
    }

    Widget pokemonArtwork() {
      return Expanded(
        child: ClipRect(
          child: Image.network(
            width: pokemonHeight * 100,
            height: pokemonHeight * 100,
            urlImage,
          ),
        ),
      );
    }

    return AppBar(
      title: Text(title),
      actions: actions,
      centerTitle: true,
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

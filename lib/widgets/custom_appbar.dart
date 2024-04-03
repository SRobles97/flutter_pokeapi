import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final int heroTag;
  final String urlImage;
  final List<Widget> actions;
  final String pokeName;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.heroTag,
    required this.urlImage,
    required this.actions,
    required this.pokeName,
    this.preferredSize = const Size.fromHeight(300.0),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String toUpper(String text) {
      return text.toUpperCase();
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
              Expanded(
                child: Image.network(
                  urlImage,
                ),
              ),
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

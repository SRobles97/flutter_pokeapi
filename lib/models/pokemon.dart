import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/helpers/types_helper.dart';
import 'package:pokemon_flutter_app/models/stats.dart';

class Pokemon {
  final int id;
  final String name;
  final double height;
  final double weight;
  final String imageUrl;
  final String spriteUrl;
  String? flavorText;
  final List<String> types;
  final String latestCryUrl;
  final Color mainColor;
  final Stats stats;

  Pokemon(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.imageUrl,
      required this.spriteUrl,
      this.flavorText,
      required this.types,
      required this.latestCryUrl,
      required this.mainColor,
      required this.stats});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = <String>[];
    for (final type in json['types']) {
      types.add(type['type']['name']);
    }

    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'].toDouble() / 10,
      weight: json['weight'].toDouble() / 10,
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      spriteUrl: json['sprites']['front_default'],
      types: types,
      latestCryUrl: json['cries']['latest'],
      mainColor: TypesHelper.getMainColour(types),
      stats: Stats.fromList(json['stats']),
    );
  }
}

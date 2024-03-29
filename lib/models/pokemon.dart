import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/helpers/types_helper.dart';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final String spriteUrl;
  final List<String> types;
  final Color mainColor;

  Pokemon(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.spriteUrl,
      required this.types,
      required this.mainColor});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = <String>[];
    for (final type in json['types']) {
      types.add(type['type']['name']);
    }
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      spriteUrl: json['sprites']['front_default'],
      types: types,
      mainColor: TypesHelper.getMainColour(types),
    );
  }
}

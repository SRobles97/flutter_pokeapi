import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/services/pokemon_services.dart';

import '../models/pokemon.dart';

final pokemonProvider = FutureProvider<List<Pokemon>>((ref) async {
  return await PokemonServices.fetchOriginalPokemon();
});

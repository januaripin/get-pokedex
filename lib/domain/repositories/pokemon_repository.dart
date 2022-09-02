import '../entities/pokemon_list_item.dart';

abstract class PokemonRepository {
  Future<List<PokemonListItem>> fetchPokemonList({
    required int limit,
    required int offset,
  });
}

import '../models/pokemon_list_item_model.dart';

abstract class PokemonDatasource {
  Future<List<PokemonListItemModel>> fetchPokemonList({
    required int limit,
    required int offset,
  });
}

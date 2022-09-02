import '../models/pokemon_list_model.dart';

abstract class PokemonDatasource {
  Future<List<PokemonListModel>> fetchPokemonList({
    required int limit,
    required int page,
  });
}

import '../entities/pokemon_list_item.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList {
  final PokemonRepository _repository;

  GetPokemonList(PokemonRepository repository) : _repository = repository;

  Future<List<PokemonListItem>> execute({
    required int limit,
    required int page,
  }) async {
    final offset = (page - 1) * limit;
    return _repository.fetchPokemonList(limit: limit, offset: offset);
  }
}

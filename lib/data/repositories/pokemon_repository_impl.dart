import '../../domain/entities/pokemon_list_item.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_datasource.dart';
import '../mappers/pokemon_list_item_mapper.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonDatasource _datasource;

  PokemonRepositoryImpl(PokemonDatasource datasource)
      : _datasource = datasource;

  @override
  Future<List<PokemonListItem>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    final models = await _datasource.fetchPokemonList(
      limit: limit,
      offset: offset,
    );

    return models
        .map((model) => PokemonListItemMapper.toEntity(model))
        .toList();
  }
}

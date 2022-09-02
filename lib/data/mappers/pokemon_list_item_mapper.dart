import '../../domain/entities/pokemon_list_item.dart';
import '../models/pokemon_list_item_model.dart';

class PokemonListItemMapper {
  static PokemonListItem toEntity(PokemonListItemModel model) =>
      PokemonListItem(name: model.name, url: model.url);
}

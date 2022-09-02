import 'pokemon_list_model.dart';

class PokemonListResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListModel> results;

  PokemonListResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonListResponseModel.fromJson(data) => PokemonListResponseModel(
        count: data['count'],
        next: data['next'],
        previous: data['previous'],
        results: List.from(
          data['results'].map((json) => PokemonListModel.fromJson(json)),
        ),
      );
}

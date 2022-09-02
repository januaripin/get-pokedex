class PokemonListModel {
  final String name;
  final String url;

  PokemonListModel({required this.name, required this.url});

  factory PokemonListModel.fromJson(json) => PokemonListModel(
        name: json['name'],
        url: json['url'],
      );
}

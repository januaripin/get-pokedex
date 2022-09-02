import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/pokemon_list_item.dart';
import '../../../domain/usecases/get_pokemon_list.dart';

class HomeController extends GetxController {
  final GetPokemonList _getPokemonList;

  HomeController(GetPokemonList getPokemonList)
      : _getPokemonList = getPokemonList;

  final _pokemons = <PokemonListItem>[].obs;

  List<PokemonListItem> get pokemons => _pokemons;

  @override
  void onInit() {
    super.onInit();
    retrievePokemonList();
  }

  void retrievePokemonList({int limit = 10, int page = 1}) {
    _getPokemonList
        .execute(limit: limit, page: page)
        .then((value) => _pokemons.addAll(value), onError: (error) {
      debugPrint(error);
    });
  }
}

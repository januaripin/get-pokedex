import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_pokedex/data/mappers/pokemon_list_item_mapper.dart';
import 'package:get_pokedex/data/models/pokemon_list_response_model.dart';
import 'package:get_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:get_pokedex/domain/usecases/get_pokemon_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemon_list_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late MockPokemonRepository mockRepository;
  late GetPokemonList getPokemonList;

  setUp(() {
    mockRepository = MockPokemonRepository();
    getPokemonList = GetPokemonList(mockRepository);
  });

  group('Get List of Pokemon', () {
    test('Test get pokemon list should success', () async {
      // arrange
      final json = File(
        'test/jsons/success_get_pokemon_list.json',
      ).readAsStringSync();
      final response = PokemonListResponseModel.fromJson(jsonDecode(json));
      final expected = response.results
          .map((result) => PokemonListItemMapper.toEntity(result))
          .toList();

      when(mockRepository.fetchPokemonList(limit: 10, offset: 0))
          .thenAnswer((_) async => expected);

      // act
      final pokemonList = await getPokemonList.execute(limit: 10, page: 1);

      // assert
      expect(pokemonList, expected);
    });
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_pokedex/data/datasources/pokemon_datasource.dart';
import 'package:get_pokedex/data/mappers/pokemon_list_item_mapper.dart';
import 'package:get_pokedex/data/models/pokemon_list_response_model.dart';
import 'package:get_pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:get_pokedex/domain/entities/pokemon_list_item.dart';
import 'package:get_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_repository_test.mocks.dart';

@GenerateMocks([PokemonDatasource])
void main() {
  late MockPokemonDatasource mockDatasource;
  late PokemonRepository repository;

  setUp(() {
    mockDatasource = MockPokemonDatasource();
    repository = PokemonRepositoryImpl(mockDatasource);
  });

  group('List of Pokemon in Repository', () {
    test('Test fetch pokemon list should success', () async {
      // arrange
      final json = File(
        'test/jsons/success_get_pokemon_list.json',
      ).readAsStringSync();
      final response = PokemonListResponseModel.fromJson(jsonDecode(json));
      final expected = response.results
          .map((result) => PokemonListItemMapper.toEntity(result))
          .toList();

      when(mockDatasource.fetchPokemonList(limit: 10, offset: 0))
          .thenAnswer((_) async => response.results);

      // act
      final result = await repository.fetchPokemonList(limit: 10, offset: 0);

      // assert
      expect(result.length, expected.length);
      expect(result.first, isA<PokemonListItem>());
    });

    test('Test fetch pokemon list should fail', () async {
      // arrange
      when(mockDatasource.fetchPokemonList(limit: 10, offset: 0))
          .thenThrow(DioError(requestOptions: RequestOptions(path: 'pokemon')));

      // act
      final result = repository.fetchPokemonList(limit: 10, offset: 0);

      // assert
      expect(result, throwsException);
    });
  });
}

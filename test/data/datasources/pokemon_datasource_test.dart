import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_pokedex/data/datasources/pokemon_datasource.dart';
import 'package:get_pokedex/data/datasources/pokemon_datasource_impl.dart';
import 'package:get_pokedex/data/models/pokemon_list_response_model.dart';

import '../../utils/mock_dio_adapter.dart';

void main() {
  late PokemonDatasource datasource;
  late Dio client;
  setUp(() {
    client = Dio();
    datasource = PokemonDatasourceImpl(client);
  });

  group('List of Pokemon', () {
    test('Test retrieve list of pokemon should return successfully', () async {
      // arrange
      final json = File(
        'test/jsons/success_get_pokemon_list.json',
      ).readAsStringSync();
      final response = PokemonListResponseModel.fromJson(jsonDecode(json));
      final expected = response.results;

      client.httpClientAdapter = MockDioAdapter.success(json);

      // act
      final result = await datasource.fetchPokemonList(limit: 10, offset: 0);

      // assert
      expect(result.length, expected.length);
      expect(result.first.name, expected.first.name);
    });

    test('Test retrieve list of pokemon should return throw exception', () {
      // arrange
      client.httpClientAdapter = MockDioAdapter.fail();

      // act
      final result = datasource.fetchPokemonList(limit: 10, offset: 0);

      // assert
      expect(result, throwsException);
    });
  });
}

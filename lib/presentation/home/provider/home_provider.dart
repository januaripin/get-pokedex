import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/datasources/pokemon_datasource.dart';
import '../../../data/datasources/pokemon_datasource_impl.dart';
import '../../../data/repositories/pokemon_repository_impl.dart';
import '../../../domain/entities/pokemon_list_item.dart';
import '../../../domain/repositories/pokemon_repository.dart';
import '../../../domain/usecases/get_pokemon_list.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'))
    ..interceptors.add(PrettyDioLogger());
});

final pokemonDatasourceProvider = Provider<PokemonDatasource>((ref) {
  return PokemonDatasourceImpl(ref.watch(dioProvider));
});

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(ref.watch(pokemonDatasourceProvider));
});

final getPokemonListProvider = Provider<GetPokemonList>((ref) {
  return GetPokemonList(ref.watch(pokemonRepositoryProvider));
});

final getPokemonList =
    FutureProvider.autoDispose.family<List<PokemonListItem>, GetPokemonListParams>(
        (ref, params) async => await ref.watch(getPokemonListProvider).execute(
              limit: params.limit,
              page: params.page,
            ));

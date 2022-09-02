import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/datasources/pokemon_datasource.dart';
import '../../../data/datasources/pokemon_datasource_impl.dart';
import '../../../data/repositories/pokemon_repository_impl.dart';
import '../../../domain/repositories/pokemon_repository.dart';
import '../../../domain/usecases/get_pokemon_list.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PokemonDatasource>(PokemonDatasourceImpl(Get.find<Dio>()));
    Get.put<PokemonRepository>(
        PokemonRepositoryImpl(Get.find<PokemonDatasource>()));
    Get.put<GetPokemonList>(GetPokemonList(Get.find<PokemonRepository>()));
    Get.put<HomeController>(HomeController(Get.find<GetPokemonList>()));
  }
}

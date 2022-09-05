import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_pokedex/data/mappers/pokemon_list_item_mapper.dart';
import 'package:get_pokedex/data/models/pokemon_list_response_model.dart';
import 'package:get_pokedex/domain/usecases/get_pokemon_list.dart';
import 'package:get_pokedex/presentation/home/get/home_controller.dart';
import 'package:get_pokedex/presentation/home/pages/home_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([GetPokemonList])
void main() {
  testWidgets('Test find Home text', (tester) async {
    // assert
    // 1. define expected data
    final json = jsonDecode(
        File('test/jsons/success_get_pokemon_list.json').readAsStringSync());
    final expected = PokemonListResponseModel.fromJson(json)
        .results
        .map((model) => PokemonListItemMapper.toEntity(model))
        .toList();

    final getPokemonList = MockGetPokemonList();

    final homeBinding = BindingsBuilder(() {
      Get.put<HomeController>(HomeController(getPokemonList));
    });

    when(getPokemonList.execute(limit: 10, page: 1))
        .thenAnswer((_) async => expected);

    // act
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: HomePage.routeName,
      getPages: [
        GetPage(
          name: HomePage.routeName,
          page: () => const HomePage(),
          binding: homeBinding,
        )
      ],
    ));

    final titleFinder = find.text('Pokedex');
    final listFinder = find.byType(Scrollable);
    final itemFinder = find.text('caterpie');

    // Scroll until the item to be found appears.
    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
      scrollable: listFinder,
    );

    // assert
    expect(titleFinder, findsOneWidget);
    expect(itemFinder, findsOneWidget);
  });
}

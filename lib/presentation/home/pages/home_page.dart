import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get/home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokedex',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final pokemon = controller.pokemons[index];
              return Card(
                child: Center(
                  child: Text(
                    pokemon.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              );
            },
            itemCount: controller.pokemons.length,
          ),
        ),
      ),
    );
  }
}

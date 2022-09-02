import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_pokedex/presentation/app/get/app_binding.dart';
import 'package:get_pokedex/presentation/home/get/home_binding.dart';
import 'package:get_pokedex/presentation/home/pages/home_page.dart';

void main() {
  testWidgets('Test find Home text', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: HomePage.routeName,
      initialBinding: AppBinding(),
      getPages: [
        GetPage(
          name: HomePage.routeName,
          page: () => const HomePage(),
          binding: HomeBinding(),
        )
      ],
    ));

    final pokedex = find.text('Pokedex');

    expect(pokedex, findsOneWidget);
  });
}

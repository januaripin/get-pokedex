import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/get/home_binding.dart';
import '../../home/pages/home_page.dart';
import '../get/app_binding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HomePage.routeName,
      initialBinding: AppBinding(),
      getPages: [
        GetPage(
          name: HomePage.routeName,
          page: () => const HomePage(),
          binding: HomeBinding(),
        )
      ],
    );
  }
}

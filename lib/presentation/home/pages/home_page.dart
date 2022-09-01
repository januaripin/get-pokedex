import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get/home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

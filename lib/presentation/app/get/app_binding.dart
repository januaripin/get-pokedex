import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/')));
  }
}

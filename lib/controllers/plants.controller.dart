import 'package:get/get.dart';

class PlantsController {
  static RxList<dynamic> userPlants = <dynamic>[].obs;

  static Future<void> fetchUserPlants() async {}

  static Future<void> addNewPlant() async {}

  static Future<void> markPlantAsWatered() async {}

  static Future<void> markPlantAsFertilized() async {}

  static void clearPlants() {
    PlantsController.userPlants.value = <dynamic>[];
  }
}

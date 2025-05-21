import 'dart:convert';

import 'package:get/get.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/services/network.service.dart';

class PlantsController {
  static RxList<PlantModel> userPlants = <PlantModel>[].obs;

  static Future<void> fetchUserPlants() async {
    final dynamic response = await NetworkService.fetchUserPlants();

    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> plantList = jsonDecode(response.body);

      PlantsController.userPlants.value =
          plantList
              .map((final dynamic plant) => PlantModel.fromMap(plant))
              .toList();
    }
  }

  static Future<void> addNewPlant() async {}

  static Future<void> markPlantAsWatered() async {}

  static Future<void> markPlantAsFertilized() async {}

  static void clearPlants() {
    PlantsController.userPlants.value = <PlantModel>[];
  }
}

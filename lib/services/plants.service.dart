import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/secrets.dart';

class PlantsService {
  static Map<String, String> buildAuthHeaders() {
    return <String, String>{
      'Authorization': 'Bearer ${UserStateController.user.value.accessToken}',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  static Future<void> fetchUserPlants() async {
    try {
      AppStateController.setLoadingState(true);

      final http.Response response = await http.get(
        Uri.parse(
          '${AppSecrets.serverUrl}/$kPlantsEndpoint/byuser/${UserStateController.user.value.userId}',
        ),
        headers: buildAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> plantList = jsonDecode(response.body);

        UserStateController.setUserPlants(
          plantList
              .map((final dynamic plant) => PlantModel.fromMap(plant))
              .toList(),
        );
      }

      AppStateController.setLoadingState(false);
    } on Exception catch (err) {
      print(err);
    }
  }

  static Future<PlantModel?> addNewPlant(final PlantModel plant) async {
    // final dynamic response = await NetworkService.addNewPlant(plant);
    try {
      AppStateController.setLoadingState(true);

      final http.Response response = await http.post(
        Uri.parse('${AppSecrets.serverUrl}/$kPlantsEndpoint/'),
        body: jsonEncode(plant.toMap()),
        headers: buildAuthHeaders(),
      );

      // Reset the UI

      AppStateController.setLoadingState(false);

      // Check to ensure record was returned successfully
      if (response.statusCode == 201) {
        // Update our local plants list in the controller
        await PlantsService.fetchUserPlants();

        return PlantModel.fromMap(jsonDecode(response.body));
      }
      return null;
    } on Exception catch (err) {
      print(err);
      return null;
    }
  }

  static Future<void> markPlantAsWatered() async {
    // TODO(RV): Add logic
  }

  static Future<void> markPlantAsFertilized() async {
    // TODO(RV): Add logic
  }

  static void clearPlants() {
    UserStateController.userPlants.value = <PlantModel>[];
  }
}

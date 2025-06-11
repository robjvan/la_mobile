import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/secrets.dart';

class PlantsService {
  // Singleton instance
  static final PlantsService _instance = PlantsService._internal();

  // Factory constructor to return the same instance
  factory PlantsService() => _instance;

  // Private constructor
  PlantsService._internal();

  /// Build authorization headers with access token
  Map<String, String> _buildAuthHeaders() {
    return <String, String>{
      'Authorization': 'Bearer ${UserStateController.user.value.accessToken}',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  /// Fetch all plants associated with the current user
  Future<void> fetchUserPlants() async {
    try {
      AppStateController.setLoadingState(true);

      final http.Response response = await http.get(
        Uri.parse(
          '${AppSecrets.serverUrl}/$kPlantsEndpoint/byuser/${UserStateController.user.value.userId}',
        ),
        headers: _buildAuthHeaders(),
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
      print('Error fetching plants: $err');
      AppStateController.setLoadingState(false);
    }
  }

  /// Add a new plant and update the local list
  Future<PlantModel?> addNewPlant(final PlantModel plant) async {
    try {
      AppStateController.setLoadingState(true);

      final http.Response response = await http.post(
        Uri.parse('${AppSecrets.serverUrl}/$kPlantsEndpoint/'),
        body: jsonEncode(plant.toMap()),
        headers: _buildAuthHeaders(),
      );

      AppStateController.setLoadingState(false);

      if (response.statusCode == 201) {
        await fetchUserPlants();
        return PlantModel.fromMap(jsonDecode(response.body));
      }

      return null;
    } on Exception catch (err) {
      print('Error adding plant: $err');
      AppStateController.setLoadingState(false);
      return null;
    }
  }

  /// Mark a plant as watered (stub)
  Future<void> markPlantAsWatered() async {
    // TODO(RV): Implement logic
  }

  /// Mark a plant as fertilized (stub)
  Future<void> markPlantAsFertilized() async {
    // TODO(RV): Implement logic
  }

  /// Clear local plant list
  void clearPlants() {
    UserStateController.userPlants.value = <PlantModel>[];
  }
}

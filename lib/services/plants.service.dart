import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/secrets.dart';
import 'package:la_mobile/utilities/theme.dart';

class PlantsService {
  // Singleton instance
  static final PlantsService _instance = PlantsService._internal();

  // Factory constructor to return the same instance
  factory PlantsService() => _instance;

  // Private constructor
  PlantsService._internal();

  /// Private method used to Build authorization headers with access token
  Map<String, String> _buildAuthHeaders() {
    return <String, String>{
      'Authorization': 'Bearer ${UserStateController.user.value.accessToken}',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  /// Private method used to build a status icon.
  static Widget _buildIcon({
    final IconData? iconData,
    final Color? color,
    final bool error = false,
  }) {
    if (error) {
      return Icon(
        Icons.error_outline,
        color: AppColors.red,
        size: 16.0, // TODO(RV): Add dynamic sizing based on grid/list view
      );
    }
    return Obx(
      () =>
          AppStateController.viewAsList.value
              ? Icon(
                iconData,
                color: color,
                size:
                    16.0, // TODO(RV): Add dynamic sizing based on grid/list view
              )
              : Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  iconData,
                  color: color,
                  size:
                      16.0, // TODO(RV): Add dynamic sizing based on grid/list view
                ),
              ),
    );
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

  /// Builds a list of status icons based on plant needs, ie. watering/fertilizer overdue.
  static List<Widget> buildTileIcons(final PlantModel plant) {
    final List<Widget> icons = <Widget>[];

    // Check for overdue plant watering
    if (plant.lastWateredAt != null && plant.waterIntervalDays != null) {
      try {
        final DateTime lastWatered = DateTime.parse(plant.lastWateredAt!);
        final DateTime nextWatering = lastWatered.add(
          Duration(days: plant.waterIntervalDays!),
        );

        if (DateTime.now().isAfter(nextWatering)) {
          icons.add(
            _buildIcon(
              iconData: Icons.opacity_rounded,
              color: AppColors.lightBlue,
            ),
          );
        }
      } on Exception catch (_) {
        icons.add(_buildIcon(error: true));
      }
    }

    // Check for overdue fertilizing
    if (plant.lastFertilizedAt != null &&
        plant.fertilizerIntervalDays != null) {
      try {
        final DateTime lastFertilized = DateTime.parse(plant.lastFertilizedAt!);
        final DateTime nextFertilizing = lastFertilized.add(
          Duration(days: plant.fertilizerIntervalDays!),
        );

        if (DateTime.now().isAfter(nextFertilizing)) {
          icons.add(_buildIcon(iconData: Icons.grain, color: Colors.brown));
        }
      } on Exception catch (_) {
        icons.add(_buildIcon(error: true));
      }
    }

    // Watering interval set but reminder not enabled
    if (plant.waterIntervalDays != null &&
        plant.wateringReminderEnabled == false) {
      icons.add(
        _buildIcon(iconData: Icons.timer_off, color: AppColors.lightBlue),
      );
    }

    // Fertilizer interval set but reminder not enabled
    if (plant.fertilizerReminderEnabled &&
        plant.fertilizerIntervalDays == null) {
      icons.add(_buildIcon(iconData: Icons.timer_off, color: Colors.brown));
    }

    return icons;
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/models/plant_action.enum.dart';
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
  static Map<String, String> _buildAuthHeaders() {
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
      return Obx(
        () => Icon(
          Icons.error_outline,
          color: AppColors.red,
          size: AppStateController.viewAsList.value ? 24 : 16.0,
        ),
      );
    }
    return Obx(
      () =>
          AppStateController.viewAsList.value
              ? Icon(
                iconData,
                color: color,

                size: AppStateController.viewAsList.value ? 24 : 16.0,
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

                  size: AppStateController.viewAsList.value ? 24 : 16.0,
                ),
              ),
    );
  }

  /// Fetch all plants associated with the current user
  static Future<void> fetchUserPlants() async {
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

  /// Clear local plant list
  void clearPlants() {
    UserStateController.userPlants.value = <PlantModel>[];
  }

  /// Builds a list of status icons based on plant needs, ie. watering/fertilizer overdue.
  static List<Widget> buildStatusIcons(final PlantModel plant) {
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
          icons.add(_buildIcon(iconData: Icons.grass, color: Colors.brown));
        }
      } on Exception catch (_) {
        icons.add(_buildIcon(error: true));
      }
    }

    // Watering interval set but reminder not enabled
    if (plant.waterIntervalDays != null && plant.reminderEnabled == false) {
      icons.add(
        _buildIcon(iconData: Icons.timer_off, color: AppColors.lightBlue),
      );
    }

    // Fertilizer interval set but reminder not enabled
    if (plant.fertilizerIntervalDays != null &&
        plant.fertilizerReminderEnabled == false) {
      icons.add(_buildIcon(iconData: Icons.timer_off, color: Colors.brown));
    }

    return icons;
  }

  /// Mark one or more plants as watered
  static Future<bool> markPlantAction(
    final List<int> plantIds, {
    required final PlantAction action,
  }) async {
    AppStateController.setLoadingState(true);
    Uri endpoint;

    switch (action) {
      case PlantAction.water:
        endpoint = Uri.parse('${AppSecrets.serverUrl}/$kPlantsEndpoint/water');
        break;
      case PlantAction.fertilize:
        endpoint = Uri.parse(
          '${AppSecrets.serverUrl}/$kPlantsEndpoint/fertilize',
        );
        break;
    }

    try {
      final http.Response response = await http.post(
        endpoint,
        body: jsonEncode(<String, dynamic>{'plantIds': plantIds}),
        headers: _buildAuthHeaders(),
      );

      AppStateController.setLoadingState(false);

      if (response.statusCode == 201) {
        await fetchUserPlants(); // Refresh local list
        // Get.back();
        return true;
      }

      // Get.back();
      return false;
    } catch (e) {
      print(
        'Error marking plants as ${action == PlantAction.water ? 'watered' : 'fertilized'}: $e',
      );
      return false;
    }
  }

  static toggleReminder(final int plantId, final PlantAction action) async {
    AppStateController.setLoadingState(true);

    print('fired');

    Uri endpoint;

    switch (action) {
      case PlantAction.water:
        endpoint = Uri.parse(
          '${AppSecrets.serverUrl}/$kPlantsEndpoint/water/toggle-reminders/$plantId',
        );
        break;
      case PlantAction.fertilize:
        endpoint = Uri.parse(
          '${AppSecrets.serverUrl}/$kPlantsEndpoint/fertilize/toggle-reminders/$plantId',
        );
        break;
    }

    try {
      final http.Response response = await http.patch(
        endpoint,
        // body: jsonEncode(<String, dynamic>{'id': plantIds}),
        headers: _buildAuthHeaders(),
      );
      AppStateController.setLoadingState(false);
      if (response.statusCode == 200) {
        await fetchUserPlants(); // Refresh local list
        // Get.back();
        return true;
      }

      // Get.back();
      return false;
    } on Exception catch (e) {
      print(
        'Error marking plants as ${action == PlantAction.water ? 'watered' : 'fertilized'}: $e',
      );
      return false;
    }
  }
}

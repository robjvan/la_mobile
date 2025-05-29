import 'package:la_mobile/models/metrics/frequency.model.dart';

class PlantMetricsModel {
  final int totalPlants;
  final int livePlants;
  final int toBeWateredToday;
  final String? mostWateredSpecies;
  final FrequencyModel wateringFrequency;
  final FrequencyModel fertilizerFrequency;
  final String? mostFertilizedSpecies;
  final int plantsAddedToday;
  final int plantsAdded7Days;
  final int plantsAdded30Days;
  final int plantsAdded90Days;

  PlantMetricsModel({
    required this.totalPlants,
    required this.livePlants,
    required this.toBeWateredToday,
    required this.mostWateredSpecies,
    required this.wateringFrequency,
    required this.fertilizerFrequency,
    required this.mostFertilizedSpecies,
    required this.plantsAddedToday,
    required this.plantsAdded7Days,
    required this.plantsAdded30Days,
    required this.plantsAdded90Days,
  });

  factory PlantMetricsModel.initial() => PlantMetricsModel(
    totalPlants: 0,
    livePlants: 0,
    toBeWateredToday: 0,
    mostWateredSpecies: null,
    wateringFrequency: FrequencyModel.initial(),
    fertilizerFrequency: FrequencyModel.initial(),
    mostFertilizedSpecies: null,
    plantsAddedToday: 0,
    plantsAdded7Days: 0,
    plantsAdded30Days: 0,
    plantsAdded90Days: 0,
  );

  factory PlantMetricsModel.fromMap(final Map<String, dynamic> json) =>
      PlantMetricsModel(
        totalPlants: json['totalPlants'],
        livePlants: json['livePlants'],
        toBeWateredToday: json['toBeWateredToday'],
        mostWateredSpecies: json['mostWateredSpecies'],
        wateringFrequency: FrequencyModel.fromMap(json['wateringFrequency']),
        fertilizerFrequency: FrequencyModel.fromMap(
          json['fertilizerFrequency'],
        ),
        mostFertilizedSpecies: json['mostFertilizedSpecies'],
        plantsAddedToday: json['plantsAddedToday'],
        plantsAdded7Days: json['plantsAdded7Days'],
        plantsAdded30Days: json['plantsAdded30Days'],
        plantsAdded90Days: json['plantsAdded90Days'],
      );

  // Map<String, dynamic> toMap() => {};
}

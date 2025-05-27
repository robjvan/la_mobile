import 'package:la_mobile/models/metrics/geographical_metrics.model.dart';
import 'package:la_mobile/models/metrics/new_user_metrics.model.dart';
import 'package:la_mobile/models/metrics/plant_metrics.model.dart';
import 'package:la_mobile/models/metrics/user_growth_metrics.model.dart';
import 'package:la_mobile/models/metrics/user_login_metrics.model.dart';
import 'package:la_mobile/models/metrics/user_metrics.model.dart';

class MetricsModel {
  final UserMetricsModel userMetrics;
  final UserLoginMetricsModel userLoginMetrics;
  final NewUserMetricsModel newUserMetrics;
  final UserGrowthMetricsModel userGrowthMetrics;
  final PlantMetricsModel plantMetrics;
  final GeographicalMetricsModel geographicalMetrics;

  MetricsModel({
    required this.userMetrics,
    required this.userLoginMetrics,
    required this.newUserMetrics,
    required this.userGrowthMetrics,
    required this.plantMetrics,
    required this.geographicalMetrics,
  });

  factory MetricsModel.initial() => MetricsModel(
    userMetrics: UserMetricsModel.initial(),
    userLoginMetrics: UserLoginMetricsModel.initial(),
    newUserMetrics: NewUserMetricsModel.initial(),
    userGrowthMetrics: UserGrowthMetricsModel.initial(),
    plantMetrics: PlantMetricsModel.initial(),
    geographicalMetrics: GeographicalMetricsModel.initial(),
  );

  factory MetricsModel.fromMap(final Map<String, dynamic> json) => MetricsModel(
    userMetrics: UserMetricsModel.fromMap(json['userMetrics']),
    userLoginMetrics: UserLoginMetricsModel.fromMap(json['userLoginMetrics']),
    newUserMetrics: NewUserMetricsModel.fromMap(json['newUserMetrics']),
    userGrowthMetrics: UserGrowthMetricsModel.fromMap(
      json['userGrowthMetrics'],
    ),
    plantMetrics: PlantMetricsModel.fromMap(json['plantMetrics']),
    geographicalMetrics: GeographicalMetricsModel.fromMap(
      json['geographicalMetrics'],
    ),
  );

  // Map<String, dynamic> toMap() => {
  //   'userMetrics': userMetrics.toMap(),
  //   'userLoginMetrics': userLoginMetrics.toMap(),
  //   'newUserMetrics': newUserMetrics.toMap(),
  //   'userGrowthMetrics': userGrowthMetrics.toMap(),
  //   'plantMetrics': plantMetrics.toMap(),
  //   'geographicalMetrics': geographicalMetrics.toMap(),
  // };
}

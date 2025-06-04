import 'dart:math' as math;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/metrics.controller.dart';
import 'package:la_mobile/pages/admin_dashboard_page/widgets/metrics_card.dart';
import 'package:la_mobile/pages/admin_dashboard_page/widgets/metrics_row.dart';
import 'package:la_mobile/services/metrics.service.dart';
import 'package:la_mobile/utilities/theme.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    MetricsService.fetchAdminMetrics();
  }

  Widget _buildLoadingPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(
            'loading-metrics'.tr,
            // 'yerp derp',
            style: TextStyle(color: AppTheme.textColor()),
          ),
        ],
      ),
    );
  }

  MetricsRow _buildUserMetricsRow() {
    return MetricsRow(
      label: 'user-metrics'.tr,
      cards: <MetricsCard>[
        MetricsCard(
          'total-users'.tr,
          MetricsController.metrics.value.userMetrics.totalUsers.toString(),
        ),
        MetricsCard(
          'active-users'.tr,
          MetricsController.metrics.value.userMetrics.activeUsers.toString(),
        ),
        MetricsCard(
          'power-users'.tr,
          MetricsController.metrics.value.userMetrics.powerUsers.toString(),
        ),
        MetricsCard(
          'have-reviewed'.tr,
          MetricsController.metrics.value.userMetrics.haveReviewed.toString(),
        ),
        MetricsCard(
          'email-not-confirmed'.tr,
          MetricsController.metrics.value.userMetrics.emailNotConfirmed
              .toString(),
        ),
      ],
    );
  }

  MetricsRow _buildUserLoginMetricsRow() {
    return MetricsRow(
      label: 'user-login-metrics'.tr,
      cards: <MetricsCard>[
        MetricsCard(
          'totalLogins'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLogins
              .toString(),
        ),
        MetricsCard(
          'totalLoginsToday'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLoginsToday
              .toString(),
        ),
        MetricsCard(
          'totalLoginsThisWeek'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLoginsThisWeek
              .toString(),
        ),
        MetricsCard(
          'totalLoginsThisMonth'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLoginsThisMonth
              .toString(),
        ),
        MetricsCard(
          'totalLogins7days'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLogins7days
              .toString(),
        ),
        MetricsCard(
          'totalLogins30days'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLogins30days
              .toString(),
        ),
        MetricsCard(
          'totalLogins90days'.tr,
          MetricsController.metrics.value.userLoginMetrics.totalLogins90days
              .toString(),
        ),
        MetricsCard(
          'totalLoginsThisYear'.tr,

          MetricsController.metrics.value.userLoginMetrics.totalLoginsThisYear
              .toString(),
        ),
      ],
    );
  }

  MetricsRow _buildNewUserMetricsRow() {
    return MetricsRow(
      label: 'new-user-metrics'.tr,
      cards: <MetricsCard>[
        MetricsCard(
          'newUsersThisWeek'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsersThisWeek
              .toString(),
        ),
        MetricsCard(
          'newUsersLastWeek'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsersLastWeek
              .toString(),
        ),
        MetricsCard(
          'newUsersThisMonth'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsersThisMonth
              .toString(),
        ),
        MetricsCard(
          'newUsersLastMonth'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsersLastMonth
              .toString(),
        ),
        MetricsCard(
          'newUsers7days'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsers7days
              .toString(),
        ),
        MetricsCard(
          'newUsers30days'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsers30days
              .toString(),
        ),
        MetricsCard(
          'newUsers90days'.tr,
          MetricsController.metrics.value.newUserMetrics.newUsers90days
              .toString(),
        ),
      ],
    );
  }

  MetricsRow _buildUserGrowthMetricsRow() {
    return MetricsRow(
      label: 'user-growth-metrics'.tr,
      cards: <MetricsCard>[
        MetricsCard(
          'userGrowthRate7days'.tr,
          MetricsController.metrics.value.userGrowthMetrics.userGrowthRate7days
              .toString(),
        ),
        MetricsCard(
          'userGrowthRate30days'.tr,
          MetricsController.metrics.value.userGrowthMetrics.userGrowthRate30days
              .toString(),
        ),
        MetricsCard(
          'userGrowthRate90days'.tr,
          MetricsController.metrics.value.userGrowthMetrics.userGrowthRate90days
              .toString(),
        ),
        MetricsCard(
          'userGrowthRateAnnual'.tr,
          MetricsController.metrics.value.userGrowthMetrics.userGrowthRateAnnual
              .toString(),
        ),
      ],
    );
  }

  MetricsRow _buildPlantMetricsRow() {
    return MetricsRow(
      label: 'plant-metrics'.tr,
      cards: <MetricsCard>[
        MetricsCard(
          'live-plants'.tr,
          MetricsController.metrics.value.plantMetrics.totalPlants.toString(),
        ),
        MetricsCard(
          'toBeWateredToday'.tr,
          MetricsController.metrics.value.plantMetrics.toBeWateredToday
              .toString(),
        ),
        MetricsCard(
          'mostWateredSpecies'.tr,
          MetricsController.metrics.value.plantMetrics.mostWateredSpecies ?? '',
        ),
        MetricsCard(
          'wateringFrequency-min'.tr,
          MetricsController
              .metrics
              .value
              .plantMetrics
              .wateringFrequency
              .minFrequency
              .toString(),
        ),
        MetricsCard(
          'wateringFrequency-avg'.tr,
          MetricsController
              .metrics
              .value
              .plantMetrics
              .wateringFrequency
              .avgFrequency
              .toString(),
        ),
        MetricsCard(
          'wateringFrequency-max'.tr,
          MetricsController
              .metrics
              .value
              .plantMetrics
              .wateringFrequency
              .maxFrequency
              .toString(),
        ),
        MetricsCard(
          'fertilizingFrequency-min'.tr,
          MetricsController
              .metrics
              .value
              .plantMetrics
              .fertilizerFrequency
              .minFrequency
              .toString(),
        ),
        MetricsCard(
          'fertilizingFrequency-avg'.tr,
          MetricsController
              .metrics
              .value
              .plantMetrics
              .fertilizerFrequency
              .avgFrequency
              .toString(),
        ),
        MetricsCard(
          'fertilizingFrequency-max'.tr,
          MetricsController
              .metrics
              .value
              .plantMetrics
              .fertilizerFrequency
              .maxFrequency
              .toString(),
        ),
        MetricsCard(
          'mostFertilizedSpecies'.tr,
          MetricsController.metrics.value.plantMetrics.mostFertilizedSpecies ??
              '',
        ),
        MetricsCard(
          'plantsAddedToday'.tr,
          MetricsController.metrics.value.plantMetrics.plantsAddedToday
              .toString(),
        ),
        MetricsCard(
          'plantsAdded7Days'.tr,
          MetricsController.metrics.value.plantMetrics.plantsAdded7Days
              .toString(),
        ),
        MetricsCard(
          'plantsAdded30Days'.tr,
          MetricsController.metrics.value.plantMetrics.plantsAdded30Days
              .toString(),
        ),
        MetricsCard(
          'plantsAdded90Days'.tr,
          MetricsController.metrics.value.plantMetrics.plantsAdded90Days
              .toString(),
        ),
      ],
    );
  }

  MetricsRow _buildGeographicalMetricsRow() {
    return MetricsRow(
      label: 'geographical-metrics'.tr,
      cards: [
        MetricsCard(
          'usersInCanada'.tr,
          MetricsController.metrics.value.geographicalMetrics.usersInCanada
              .toString(),
        ),
        MetricsCard(
          'usersInUSA'.tr,
          MetricsController.metrics.value.geographicalMetrics.usersInUSA
              .toString(),
        ),
        MetricsCard(
          'usersInOther'.tr,
          MetricsController.metrics.value.geographicalMetrics.usersInOther
              .toString(),
        ),
        MetricsCard(
          'topCountryByUsers'.tr,
          MetricsController
                  .metrics
                  .value
                  .geographicalMetrics
                  .topCountryByUsers ??
              '',
        ),
        MetricsCard(
          'topCountryNumUsers'.tr,
          MetricsController.metrics.value.geographicalMetrics.topCountryNumUsers
              .toString(),
        ),
        MetricsCard(
          'topCountryByLogins'.tr,
          MetricsController
                  .metrics
                  .value
                  .geographicalMetrics
                  .topCountryByLogins ??
              '',
        ),
        MetricsCard(
          'topCountryNumLogins'.tr,
          MetricsController
              .metrics
              .value
              .geographicalMetrics
              .topCountryNumLogins
              .toString(),
        ),
      ],
    );
  }

  Future<void> onRefresh() async {
    await MetricsService.fetchAdminMetrics();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor(),
      body: Obx(
        () =>
            AppStateController.isLoading.value
                ? _buildLoadingPage()
                : SafeArea(
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomMaterialIndicator(
                        onRefresh: onRefresh,
                        backgroundColor: Colors.white,
                        indicatorBuilder: (
                          final BuildContext context,
                          final IndicatorController controller,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: CircularProgressIndicator(
                              color: Colors.green,
                              value:
                                  AppStateController.isLoading.value
                                      ? null
                                      : math.min(controller.value, 1.0),
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              _buildUserMetricsRow(),
                              _buildUserLoginMetricsRow(),
                              _buildNewUserMetricsRow(),
                              _buildUserGrowthMetricsRow(),
                              _buildPlantMetricsRow(),
                              _buildGeographicalMetricsRow(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}

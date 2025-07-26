import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/pages/plant_details_page/plant_details.page.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
// import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantListTile extends StatelessWidget {
  final PlantModel plant;
  const PlantListTile(this.plant, {super.key});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: _buildTile(),
    );
  }

  Widget _buildTile() {
    return GestureDetector(
      onTap: () => Get.to(() => PlantDetailsPage(plant)),
      // onTap: () => Get.dialog(PlantDetailsDialog(plant.obs)),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow:
              AppStateController.useDarkMode.value
                  ? <BoxShadow>[]
                  : <BoxShadow>[
                    BoxShadow(
                      color:
                          AppStateController.useDarkMode.value
                              ? Colors.white54
                              : Colors.black38,
                      offset: Offset(2, 2),
                      spreadRadius: 1.0,
                      blurRadius: 4.0,
                    ),
                  ],
          image:
              plant.imageUrls != null
                  ? DecorationImage(
                    alignment: Alignment.center,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8),
                      BlendMode.saturation,
                    ),
                    fit: BoxFit.cover,
                    image:
                        (plant.imageUrls != null) &&
                                plant.imageUrls!.isNotEmpty &&
                                plant.imageUrls![0] != null
                            ? NetworkImage(plant.imageUrls![0])
                            : AssetImage('assets/images/image_placeholder.png'),
                  )
                  : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: <Widget>[
              _buildPlantImage(),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color:
                        AppStateController.useDarkMode.value
                            ? Colors.black54
                            : Colors.white70,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[_buildTitle(), _buildSubtitle()],
                  ),
                ),
              ),
              Spacer(),
              _buildTrailingIcons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the plant image preview. If no image is available, uses generic placeholder image.
  Widget _buildPlantImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80.0,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(4),
          child:
              (plant.imageUrls != null) &&
                      plant.imageUrls!.isNotEmpty &&
                      plant.imageUrls![0] != null
                  ? CachedNetworkImage(
                    imageUrl: plant.imageUrls![0],
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    'assets/images/image_placeholder.png',
                    fit: BoxFit.cover,
                  ),
        ),
      ),
    );
  }

  /// Builds the plant title widget.
  Widget _buildTitle() {
    return Obx(
      () => Text(
        plant.name!.capitalize!,
        style: TextStyle(
          color:
              AppStateController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  /// Builds the plant subtitle widget.  This may be a warning message or description.
  Widget _buildSubtitle() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            plant.lastWateredAt != null
                ? 'Last watered: ${DateFormat.yMMMd().format(DateTime.parse(plant.lastWateredAt!))}'
                    .tr // TODO(RV): Add i18n strings
                : 'plants.no-watering-records'.tr,
            style: TextStyle(
              color:
                  AppStateController.useDarkMode.value
                      ? AppColors.textColorDarkMode
                      : AppColors.textColorLightMode,
              fontStyle:
                  plant.lastWateredAt != null
                      ? FontStyle.normal
                      : FontStyle.italic,
            ),
          ),
          Text(
            plant.lastFertilizedAt != null
                ? 'Last fertilized:${DateFormat.yMMMd().format(DateTime.parse(plant.lastFertilizedAt!))}'
                    .tr // TODO(RV): Add i18n strings
                : 'plants.no-fertilizer-records'.tr,
            style: TextStyle(
              color:
                  AppStateController.useDarkMode.value
                      ? AppColors.textColorDarkMode
                      : AppColors.textColorLightMode,
              fontStyle:
                  plant.lastFertilizedAt != null
                      ? FontStyle.normal
                      : FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a row of status icons based on plant needs, ie. watering/fertilizer overdue.
  Widget _buildTrailingIcons() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: PlantsService.buildStatusIcons(plant),
        ),
      ),
    );
  }
}

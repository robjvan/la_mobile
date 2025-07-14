import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantListTile extends StatelessWidget {
  final PlantModel plant;
  const PlantListTile(this.plant, {super.key});

  List<Icon> buildTrailingIcons() {
    final List<Icon> icons = <Icon>[];

    // Overdue watering logic
    if (plant.lastWateredAt != null && plant.waterIntervalDays != null) {
      try {
        final DateTime lastWatered = DateTime.parse(plant.lastWateredAt!);
        final DateTime nextWatering = lastWatered.add(
          Duration(days: plant.waterIntervalDays!),
        );

        if (DateTime.now().isAfter(nextWatering)) {
          icons.add(
            Icon(Icons.opacity_rounded, color: AppColors.lightBlue),
          ); // water droplet icon
        }
      } on Exception catch (_) {
        icons.add(Icon(Icons.error_outline, color: AppColors.red));
      }
    }

    // Overdue fertilizing logic
    if (plant.lastFertilizedAt != null &&
        plant.fertilizerIntervalDays != null) {
      try {
        final DateTime lastFertilized = DateTime.parse(plant.lastFertilizedAt!);
        final DateTime nextFertilizing = lastFertilized.add(
          Duration(days: plant.fertilizerIntervalDays!),
        );

        if (DateTime.now().isAfter(nextFertilizing)) {
          icons.add(Icon(Icons.grain, color: Colors.brown)); // fertilizer icon
        }
      } on Exception catch (_) {
        icons.add(Icon(Icons.error, color: AppColors.red));
      }
    }

    // Interval set but reminder not enabled interval
    // if (plant.waterIntervalDays != null &&
    //     plant.wateringReminderEnabled == false) {
    //   icons.add(Icon(Icons.timer_off, color: AppColors.grey));
    // }

    // if (plant.fertilizerReminderEnabled &&
    //     plant.fertilizerIntervalDays == null) {
    //   icons.add(Icon(Icons.timer_off, color: AppColors.grey));
    // }

    return icons;
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Obx(
        () => ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          tileColor:
              AppStateController.useDarkMode.value
                  ? Colors.white10
                  : const Color(0xFFEEEEEE),
          onTap: () => Get.dialog(PlantDetailsDialog(plant)),
          leading: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(4),
            child:
                (plant.imageUrls != null) &&
                        plant.imageUrls!.isNotEmpty &&
                        plant.imageUrls![0] != null
                    ? CachedNetworkImage(
                      imageUrl: plant.imageUrls![0],
                      width: 56.0,
                      fit: BoxFit.cover,
                    )
                    : Image.asset('assets/images/image_placeholder.png'),
          ),
          title: Text(
            plant.name ?? '',
            style: TextStyle(color: AppTheme.textColor()),
          ),
          subtitle: Text(
            plant.lastWateredAt != null
                ? 'Last watered: ${plant.lastWateredAt!.substring(0, 10)}'
                    .tr // TODO(RV): Add i18n strings
                : 'plants.no-records'.tr,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: buildTrailingIcons(),
          ),
        ),
      ),
    );
  }
}

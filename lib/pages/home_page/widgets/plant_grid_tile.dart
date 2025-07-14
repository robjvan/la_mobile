import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantGridTile extends StatelessWidget {
  final PlantModel plant;
  const PlantGridTile(this.plant, {super.key});

  List<Widget> buildTrailingIcons() {
    final List<Widget> icons = <Widget>[];

    // Overdue watering logic
    if (plant.lastWateredAt != null && plant.waterIntervalDays != null) {
      try {
        final DateTime lastWatered = DateTime.parse(plant.lastWateredAt!);
        final DateTime nextWatering = lastWatered.add(
          Duration(days: plant.waterIntervalDays!),
        );

        if (DateTime.now().isAfter(nextWatering)) {
          icons.add(
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.opacity_rounded,
                color: AppColors.lightBlue,
                size: 16.0,
              ),
            ),
          ); // water droplet icon
        }
      } on Exception catch (_) {
        icons.add(Icon(Icons.error_outline, color: AppColors.red, size: 16.0));
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
          icons.add(
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.grain, color: Colors.brown, size: 16.0),
            ),
          ); // fertilizer icon
        }
      } on Exception catch (_) {
        icons.add(Icon(Icons.error, color: AppColors.red, size: 16.0));
      }
    }

    // Interval set but reminder not enabled interval
    // if (plant.waterIntervalDays != null &&
    //     plant.wateringReminderEnabled == false) {
    //   icons.add(Icon(Icons.timer_off, color: AppColors.grey, size: 16.0));
    // }

    // if (plant.fertilizerReminderEnabled &&
    //     plant.fertilizerIntervalDays == null) {
    //   icons.add(Icon(Icons.timer_off, color: AppColors.grey, size: 16.0));
    // }

    return icons;
  }

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        unawaited(Get.dialog(PlantDetailsDialog(plant)));
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: Stack(
          children: <Widget>[
            GridTile(
              // header: Container(
              //   padding: const EdgeInsets.only(top: 4.0, right: 4.0, bottom: 4.0),
              //   color: Colors.red.withAlpha(220),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: buildTrailingIcons(),
              //   ),
              // ),
              footer: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black54),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        // width: 70,
                        child: Text(
                          plant.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child:
                  (plant.imageUrls != null) &&
                          plant.imageUrls!.isNotEmpty &&
                          plant.imageUrls![0] != null
                      ? CachedNetworkImage(
                        imageUrl: plant.imageUrls![0],
                        fit: BoxFit.cover,
                      )
                      : Image.asset('assets/images/image_placeholder.png'),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                spacing: 4.0,
                mainAxisAlignment: MainAxisAlignment.end,
                children: buildTrailingIcons(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

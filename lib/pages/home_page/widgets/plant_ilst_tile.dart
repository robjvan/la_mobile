import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantListTile extends StatelessWidget {
  final PlantModel plant;
  const PlantListTile(this.plant, {super.key});

  @override
  Widget build(final BuildContext context) {
    return ListTile(
      onTap: () {
        Get.dialog(PlantDetailsDialog(plant));
      },
      leading:
          (plant.imageUrls != null) && (plant.imageUrls!.isNotEmpty)
              ? CachedNetworkImage(imageUrl: plant.imageUrls![0])
              : Image.asset('assets/images/image_placeholder.png'),
      title: Text(
        plant.name ?? '',
        style: TextStyle(
          color:
              SettingsController.useDarkMode.value
                  ? AppColors.textColorDarkMode
                  : AppColors.textColorLightMode,
        ),
      ),
      subtitle: Text(
        plant.lastWateredAt != null
            ? 'Last watered: ${plant.lastWateredAt}'
            : 'No watering records yet!',
      ),
      trailing:
          (plant.imageUrls == null) || (plant.imageUrls!.isEmpty)
              ? Icon(Icons.warning_rounded, color: AppColors.red)
              : null,
    );
  }
}

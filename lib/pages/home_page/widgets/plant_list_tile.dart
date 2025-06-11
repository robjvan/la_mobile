import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantListTile extends StatelessWidget {
  final PlantModel plant;
  const PlantListTile(this.plant, {super.key});

  Icon? buildTrailingIcon() {
    Icon? icon;

    if (plant.lastWateredAt == null) {
      icon = Icon(Icons.warning_rounded, color: AppColors.red);
    }
    // TODO(RV): Add check for overdue watering or fertilizing, overwrite icon as necessary

    return icon;
  }

  @override
  Widget build(final BuildContext context) {
    return ListTile(
      onTap: () {
        Get.dialog(PlantDetailsDialog(plant));
      },
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
      trailing: buildTrailingIcon(),
    );
  }
}

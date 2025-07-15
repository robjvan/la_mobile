import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantListTile extends StatelessWidget {
  final PlantModel plant;
  const PlantListTile(this.plant, {super.key});

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
          leading: _buildPlantImage(),
          title: _buildTitle(),
          subtitle: _buildSubtitle(),
          trailing: _buildTrailingIcons(),
        ),
      ),
    );
  }

  /// Builds the plant image preview. If no image is available, uses generic placeholder image.
  Widget _buildPlantImage() {
    return ClipRRect(
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
    );
  }

  /// Builds the plant title widget.
  Text _buildTitle() {
    return Text(
      plant.name ?? '',
      style: TextStyle(color: AppTheme.textColor()),
    );
  }

  /// Builds the plant subtitle widget.  This may be a warning message or description.
  Text _buildSubtitle() {
    return Text(
      plant.lastWateredAt != null
          ? 'Last watered: ${plant.lastWateredAt!.substring(0, 10)}'
              .tr // TODO(RV): Add i18n strings
          : 'plants.no-records'.tr,
    );
  }

  /// Builds a row of status icons based on plant needs, ie. watering/fertilizer overdue.
  Row _buildTrailingIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: PlantsService.buildTileIcons(plant),
    );
  }
}

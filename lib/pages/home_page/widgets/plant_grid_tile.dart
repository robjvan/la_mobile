import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/plant_details.dialog.dart';

class PlantGridTile extends StatelessWidget {
  final PlantModel plant;
  const PlantGridTile(this.plant, {super.key});

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
              footer: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black54),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(children: <Widget>[_buildTitle()]),
                ),
              ),
              child: _buildPlantImage(),
            ),
            _buildTrailingIcons(),
          ],
        ),
      ),
    );
  }

  /// Builds the plant title widget.
  Text _buildTitle() {
    return Text(
      plant.name ?? '',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: AppColors.white),
    );
  }

  /// Builds the plant image preview. If no image is available, uses generic placeholder image.
  Widget _buildPlantImage() {
    return (plant.imageUrls != null) &&
            plant.imageUrls!.isNotEmpty &&
            plant.imageUrls![0] != null
        ? CachedNetworkImage(imageUrl: plant.imageUrls![0], fit: BoxFit.cover)
        : Image.asset('assets/images/image_placeholder.png');
  }

  /// Builds a row of status icons based on plant needs, ie. watering/fertilizer overdue.
  Container _buildTrailingIcons() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        spacing: 4.0,
        mainAxisAlignment: MainAxisAlignment.end,
        children: PlantsService.buildTileIcons(plant),
      ),
    );
  }
}

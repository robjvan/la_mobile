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

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        unawaited(Get.dialog(PlantDetailsDialog(plant)));
      },
      child: GridTile(
        footer: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white24),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 4.0),
            child: Row(
              children: <Widget>[
                Text(plant.name ?? '', overflow: TextOverflow.ellipsis),
                Spacer(),
                (plant.imageUrls == null) || (plant.imageUrls!.isEmpty)
                    ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.warning_rounded,
                        size: 16.0,
                        color: AppColors.red,
                      ),
                    )
                    : Container(),
              ],
            ),
          ),
        ),
        child:
            (plant.imageUrls != null) && (plant.imageUrls!.isNotEmpty)
                ? CachedNetworkImage(imageUrl: plant.imageUrls![0])
                : Image.asset('assets/images/image_placeholder.png'),
      ),
    );
  }
}

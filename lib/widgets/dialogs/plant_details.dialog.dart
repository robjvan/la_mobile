import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/utilities/theme.dart';

class PlantDetailsDialog extends StatelessWidget {
  final PlantModel plant;
  const PlantDetailsDialog(this.plant, {super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => SimpleDialog(
        backgroundColor: AppTheme.backgroundColor(),
        title: Text(
          plant.name ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.textColor()),
        ),
        children: <Widget>[
          Text('blah blah'.tr, style: TextStyle(color: AppTheme.textColor())),
          Text(
            'blah blah blah'.tr,
            style: TextStyle(color: AppTheme.textColor()),
          ),
        ],
      ),
    );
  }
}

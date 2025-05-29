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
        backgroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        title: Text(
          plant.name ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color:
                AppStateController.useDarkMode.value
                    ? AppColors.textColorDarkMode
                    : AppColors.textColorLightMode,
          ),
        ),
        children: <Widget>[
          Text(
            'blah blah'.tr,
            style: TextStyle(
              color:
                  AppStateController.useDarkMode.value
                      ? AppColors.textColorDarkMode
                      : AppColors.textColorLightMode,
            ),
          ),
          Text(
            'blah blah blah'.tr,
            style: TextStyle(
              color:
                  AppStateController.useDarkMode.value
                      ? AppColors.textColorDarkMode
                      : AppColors.textColorLightMode,
            ),
          ),
        ],
      ),
    );
  }
}

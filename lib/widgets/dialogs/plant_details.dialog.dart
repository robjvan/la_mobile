import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/models/plant_action.enum.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/delete_confirm.dialog.dart';

class PlantDetailsDialog extends StatelessWidget {
  final Rx<PlantModel> plant;

  const PlantDetailsDialog(this.plant, {super.key});

  String? _formatNextDate(final String? lastDate, final int? intervalDays) {
    if (lastDate == null || intervalDays == null) return null;
    try {
      final DateTime nextDate = DateTime.parse(
        lastDate,
      ).add(Duration(days: intervalDays));
      return DateFormat('MMM d, yyyy').format(nextDate);
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Widget build(final BuildContext context) {
    final String? nextWater = _formatNextDate(
      plant.value.lastWateredAt,
      plant.value.waterIntervalDays,
    );
    final String? nextFert = _formatNextDate(
      plant.value.lastFertilizedAt,
      plant.value.fertilizerIntervalDays,
    );

    return Obx(
      () => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor:
            AppStateController.useDarkMode.value
                ? Colors.grey[900]
                : AppColors.bgColorLightMode,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Header
              Obx(
                () => Text(
                  plant.value.name ??
                      'Unnamed Plant'.tr, // TODO(RV): Add i18n strings
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        AppStateController.useDarkMode.value
                            ? AppColors.textColorDarkMode
                            : AppColors.textColorLightMode,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (plant.value.species != null)
                Obx(
                  () => Text(
                    plant.value.species!,
                    style: TextStyle(
                      color:
                          AppStateController.useDarkMode.value
                              ? AppColors.textColorDarkMode
                              : AppColors.textColorLightMode,
                    ),
                  ),
                ),

              // const SizedBox(height: 16),

              // // Status Icons
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: PlantsService.buildTileIcons(plant),
              // ),

              // const Divider(height: 32, color: Colors.white24),

              // Reminder Toggles
              _buildReminderRow(
                label:
                    'Watering reminder enabled'
                        .tr, // TODO(RV): Add i18n strings
                value: plant.value.reminderEnabled!,
                onToggle: () async {
                  final bool success = await PlantsService.toggleReminder(
                    plant.value.id!,
                    PlantAction.water,
                  );
                  if (success) {
                    await PlantsService.fetchUserPlants();
                    final PlantModel updated = UserStateController.userPlants
                        .firstWhere(
                          (final PlantModel elem) => elem.id == plant.value.id!,
                        );
                    plant.value = updated;
                  }
                },
                nextDue: nextWater,
              ),
              _buildReminderRow(
                label:
                    'Fertilizer reminder enabled'
                        .tr, // TODO(RV): Add i18n strings
                value: plant.value.fertilizerReminderEnabled,
                onToggle: () async {
                  final bool success = await PlantsService.toggleReminder(
                    plant.value.id!,
                    PlantAction.fertilize,
                  );
                  if (success) {
                    await PlantsService.fetchUserPlants();
                    final PlantModel updated = UserStateController.userPlants
                        .firstWhere(
                          (final PlantModel elem) => elem.id == plant.value.id!,
                        );
                    plant.value = updated;
                  }
                },
                nextDue: nextFert,
              ),

              const SizedBox(height: 24),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _actionButton(
                    Icons.opacity,
                    'Mark Watered'.tr, // TODO(RV): Add i18n strings
                    () {
                      PlantsService.markPlantAction(<int>[
                        plant.value.id!,
                      ], action: PlantAction.water);
                    },
                  ),
                  _actionButton(
                    Icons.grass,
                    'Mark Fertilized'.tr, // TODO(RV): Add i18n strings
                    () {
                      PlantsService.markPlantAction(<int>[
                        plant.value.id!,
                      ], action: PlantAction.fertilize);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Edit/Delete Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: Get.back,
                    icon: Obx(
                      () => Icon(
                        Icons.edit,
                        color:
                            AppStateController.useDarkMode.value
                                ? AppColors.textColorDarkMode
                                : AppColors.textColorLightMode,
                      ),
                    ),
                    label: Obx(
                      () => Text(
                        'Edit'.tr, // TODO(RV): Add i18n strings
                        style: TextStyle(
                          color:
                              AppStateController.useDarkMode.value
                                  ? AppColors.textColorDarkMode
                                  : AppColors.textColorLightMode,
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.dialog(DeleteConfirmDialog(plant.value));
                    },
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    label: Text(
                      'Delete'.tr, // TODO(RV): Add i18n strings
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminderRow({
    required final String label,
    required final bool value,
    required final VoidCallback onToggle,
    final String? nextDue,
  }) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Obx(
                () => Text(
                  label,
                  style: TextStyle(
                    color:
                        AppStateController.useDarkMode.value
                            ? AppColors.textColorDarkMode
                            : AppColors.textColorLightMode,
                  ),
                ),
              ),
            ),
            Switch.adaptive(
              value: value,
              onChanged: (_) => onToggle(),
              activeColor: Colors.greenAccent,
            ),
          ],
        ),
        if (nextDue != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                'Next due: $nextDue',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color:
                      AppStateController.useDarkMode.value
                          ? AppColors.textColorDarkMode
                          : AppColors.textColorLightMode,
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _actionButton(
    final IconData icon,
    final String label,
    final VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24.0),
      label: SizedBox(
        width: 64,
        child: Text(label, textAlign: TextAlign.center),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/models/plant_action.enum.dart';
import 'package:la_mobile/services/plants.service.dart';

class RecordPlantActionPage extends StatefulWidget {
  final PlantAction action;

  const RecordPlantActionPage({required this.action, super.key});

  @override
  State<RecordPlantActionPage> createState() => _RecordPlantActionPageState();
}

class _RecordPlantActionPageState extends State<RecordPlantActionPage> {
  final RxList<int> _selectedPlantIds = <int>[].obs;

  @override
  Widget build(final BuildContext context) {
    final String actionLabel = _getActionLabel(widget.action);

    return Scaffold(
      appBar: AppBar(title: Text('Record $actionLabel')),
      body: Obx(() {
        final RxList<PlantModel> plants = UserStateController.userPlants;

        if (plants.isEmpty) {
          return Center(child: Text('No plants available.'.tr));
        }

        return ListView.builder(
          itemCount: plants.length,
          itemBuilder: (final BuildContext context, final int index) {
            final PlantModel plant = plants[index];

            return Obx(
              () => CheckboxListTile(
                title: Text(plant.name ?? 'Unnamed Plant'.tr),
                subtitle: Text(plant.species ?? ''),
                value: _selectedPlantIds.contains(plant.id),
                secondary: CircleAvatar(
                  backgroundImage:
                      plant.imageUrls!.isNotEmpty
                          ? NetworkImage(plant.imageUrls?.first ?? '')
                          : const AssetImage(
                                'assets/images/image_placeholder.png',
                              )
                              as ImageProvider,
                ),
                onChanged: (final bool? checked) {
                  if (checked == true) {
                    _selectedPlantIds.add(plant.id!);
                  } else {
                    _selectedPlantIds.remove(plant.id!);
                  }
                  _selectedPlantIds.refresh();
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitAction,
        icon: Icon(_getActionIcon(widget.action)),
        label: Text('Mark ${_getActionPastTense(widget.action)}'.tr),
      ),
    );
  }

  Future<void> _submitAction() async {
    if (_selectedPlantIds.isEmpty) {
      Get.snackbar('No Selection'.tr, 'Please select at least one plant.'.tr);
      return;
    }

    AppStateController.setLoadingState(true);

    final success = await PlantsService.markPlantAction(
      action: widget.action,
      _selectedPlantIds.toList(),
    );

    AppStateController.setLoadingState(false);

    if (success) {
      Get.back();
      Get.snackbar(
        'Success'.tr,
        'Plants ${_getActionPastTense(widget.action)} successfully!'.tr,
      );
    } else {
      Get.snackbar(
        'Error'.tr,
        'Failed to record ${_getActionPastTense(widget.action)}.'.tr,
      );
    }
  }

  String _getActionLabel(final PlantAction action) {
    switch (action) {
      case PlantAction.water:
        return 'Watering'.tr; // TODO(RV): Add i18n strings
      case PlantAction.fertilize:
        return 'Fertilizing'.tr; // TODO(RV): Add i18n strings
    }
  }

  String _getActionPastTense(final PlantAction action) {
    switch (action) {
      case PlantAction.water:
        return 'watered'.tr; // TODO(RV): Add i18n strings
      case PlantAction.fertilize:
        return 'fertilized'.tr; // TODO(RV): Add i18n strings
    }
  }

  IconData _getActionIcon(final PlantAction action) {
    switch (action) {
      case PlantAction.water:
        return Icons.water_drop;
      case PlantAction.fertilize:
        return Icons.eco;
    }
  }
}

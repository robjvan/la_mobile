import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/services/plants.service.dart';

class RecordWateringPage extends StatefulWidget {
  const RecordWateringPage({super.key});

  @override
  State<RecordWateringPage> createState() => _RecordWateringPageState();
}

class _RecordWateringPageState extends State<RecordWateringPage> {
  // Track selected plant IDs
  final RxList<int> _selectedPlantIds = <int>[].obs;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Record Watering'.tr, // TODO(RV): Add i18n strings
        ),
      ),
      body: Obx(() {
        final RxList<PlantModel> plants = UserStateController.userPlants;

        if (plants.isEmpty) {
          return Center(
            child: Text(
              'No plants available.'.tr, // TODO(RV): Add i18n strings
            ),
          );
        }

        return ListView.builder(
          itemCount: plants.length,
          itemBuilder: (final BuildContext context, final int index) {
            final PlantModel plant = plants[index];
            // final bool isSelected = _selectedPlantIds.contains(plant.id);

            return Obx(
              () => CheckboxListTile(
                title: Text(
                  plant.name ??
                      'Unnamed Plant'.tr, // TODO(RV): Add i18n strings
                ),
                subtitle: Text(plant.species ?? ''),
                value: _selectedPlantIds.contains(plant.id),
                secondary: CircleAvatar(
                  backgroundImage:
                      plant.imageUrls!.isNotEmpty
                          ? NetworkImage(plant.imageUrls?.first ?? '')
                          : AssetImage('assets/images/image_placeholder.png'),
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
        onPressed: _submitWatering,
        icon: const Icon(Icons.water_drop),
        label: Text(
          'Mark Watered'.tr, // TODO(RV): Add i18n strings
        ),
      ),
    );
  }

  Future<void> _submitWatering() async {
    if (_selectedPlantIds.isEmpty) {
      Get.snackbar(
        'No Selection'.tr, // TODO(RV): Add i18n strings
        'Please select at least one plant.'.tr, // TODO(RV): Add i18n strings
      );
      return;
    }

    AppStateController.setLoadingState(true);

    final success = await PlantsService.markPlantAction(
      action: PlantAction.water,
      _selectedPlantIds.toList(),
    );

    if (success) {
      Get.back();
      Get.snackbar(
        'Success'.tr, // TODO(RV): Add i18n strings
        'Watering recorded!'.tr, // TODO(RV): Add i18n strings
      );
    } else {
      Get.snackbar(
        'Error'.tr, // TODO(RV): Add i18n strings
        'Failed to record watering.'.tr, // TODO(RV): Add i18n strings
      );
    }
  }
}

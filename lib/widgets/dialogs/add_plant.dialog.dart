import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';

enum PreferenceEnum { low, medium, high }

class AddPlantDialog extends StatefulWidget {
  const AddPlantDialog({super.key});

  @override
  State<AddPlantDialog> createState() => _AddPlantDialogState();
}

class _AddPlantDialogState extends State<AddPlantDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Fields to hold new plant data
  TextEditingController nameController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController soilTypeController = TextEditingController();
  String? soilType;
  String? humidityPreference;
  String? sunlightPreference;
  String? lastWateredAt;
  String? lastFertilizedAt;
  bool? wateringReminderEnabled;
  bool? fertilizedReminderEnabled;
  double? waterAmount;
  List<String> tags = <String>[];
  List<String> notes = <String>[];
  int? fertilizerIntervalDays;
  int? waterIntervalDays;
  String? imageUrl;

  // Used to create a dynamic experience while processing completes
  bool isLoading = false;

  @override
  void dispose() {
    // Dispose of our text controllers
    nameController.dispose();
    speciesController.dispose();
    locationController.dispose();
    noteController.dispose();
    soilTypeController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    try {
      AppStateController.isLoading.value = true;

      if (formKey.currentState!.validate()) {
        final PlantModel? result = await PlantsService.addNewPlant(
          PlantModel(
            name: nameController.text,
            species: speciesController.text,
            imageUrls: <String?>[imageUrl], // Implement image Url
            archived: false,
            fertilizerIntervalDays: fertilizerIntervalDays,
            fertilizerReminderEnabled: fertilizedReminderEnabled,
            humidityPreference: humidityPreference,
            lastFertilizedAt: lastFertilizedAt,
            lastWateredAt: lastWateredAt,
            location: locationController.text,
            notes: notes,
            soilType: soilTypeController.text,
            sunlightPreference: sunlightPreference,
            tags: tags,
            waterAmount: waterAmount,
            waterIntervalDays: waterIntervalDays,
          ),
        );

        if (result != null) {
          // TODO(RV): Show success toast?
          Get.back();
        } else {
          // TODO(RV): Add error dialog - "could not create plant record, try again later"
        }
      }
    } on Exception catch (e) {
      debugPrint('Failed to create new plant record');
      print(e);
    }
  }

  InputDecoration textInputBorder(final String? hintText) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      hintText: hintText,
    );
  }

  TextFormField buildTextInputField({
    required final TextEditingController controller,
    required final String? hintText,
    required final FormFieldValidator? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: textInputBorder(hintText),
      autovalidateMode: AutovalidateMode.onUnfocus,
    );
  }

  ElevatedButton buildSubmitButton() {
    return ElevatedButton(onPressed: onSubmit, child: Text('Submit'));
  }

  TextButton buildCancelButton() {
    return TextButton(
      onPressed: Get.back,
      child: Text(
        'cancel'.tr, // TODO(RV): Add i18n strings
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Obx(
          () => Scaffold(
            backgroundColor:
                AppStateController.useDarkMode.value
                    ? AppColors.bgColorDarkMode
                    : AppColors.bgColorLightMode,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Text(
                      'add-plant'.tr, // TODO(RV): Add i18n strings
                      style: TextStyle(fontSize: 40.0, color: AppColors.green),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                            ),
                            child: Column(
                              children: <Widget>[
                                // Name field
                                buildTextInputField(
                                  controller: nameController,
                                  hintText:
                                      'e.g. "Spider Plant" or "Mom\'s Lily"'
                                          .tr, // TODO(RV): Add i18n strings
                                  validator: (final dynamic val) {
                                    // if (val == null) {
                                    //   return 'Name cannot be empty!'
                                    //       .tr; // TODO(RV): Add i18n strings
                                    // }
                                    return null;
                                  },
                                ),

                                // Species field
                                buildTextInputField(
                                  controller: speciesController,
                                  hintText:
                                      'e.g. "Chlorophytum comosum" or "African Lily"'
                                          .tr, // TODO(RV): Add i18n strings
                                  validator: (final dynamic val) => null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  buildSubmitButton(),
                  const SizedBox(height: 8.0),
                  buildCancelButton(),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

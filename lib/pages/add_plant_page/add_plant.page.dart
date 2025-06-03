import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/cancel_button.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/date_picker.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/image_box.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/notes_field.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/number_picker.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/reminder_toggle.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/submit_button.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/tags_field.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/text_input_field.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/dialogs/error_dialog.dart';

enum PreferenceEnum { low, medium, high }

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Fields to hold new plant data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _soilTypeController = TextEditingController();
  final TextEditingController _wateringIntervalController =
      TextEditingController();
  final TextEditingController _fertilizerIntervalController =
      TextEditingController();

  PreferenceEnum? _humidityPreference;
  PreferenceEnum? _sunlightPreference;
  DateTime? _lastWateredAt;
  DateTime? _lastFertilizedAt;
  bool _wateringReminderEnabled = true;
  bool _fertilizerReminderEnabled = false;
  double? _waterAmount;
  final List<String> _tags = <String>[];
  final List<String> _notes = <String>[];
  String? _imageUrl;

  // Used to create a dynamic experience while processing completes
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _wateringIntervalController.text = '2';
    _fertilizerIntervalController.text = '7';
  }

  @override
  void dispose() {
    // Dispose of our text controllers
    _nameController.dispose();
    _speciesController.dispose();
    _locationController.dispose();
    _noteController.dispose();
    _soilTypeController.dispose();
    _wateringIntervalController.dispose();
    _fertilizerIntervalController.dispose();

    super.dispose();
  }

  Future<void> onSubmit() async {
    bool _formValid = false;
    try {
      AppStateController.setLoadingState(true);

      _formValid = _formKey.currentState!.validate();

      if (_wateringReminderEnabled) {
        if (_lastWateredAt == null) {
          _formValid = false;
          await Get.dialog(ErrorDialog('new-plant.no-empty-watered-date'.tr));
        }
      }

      if (_fertilizerReminderEnabled) {
        if (_lastFertilizedAt == null) {
          _formValid = false;
          await Get.dialog(ErrorDialog('new-plant.no-empty-fertiized-date'.tr));
        }
      }

      if (_formValid) {
        final PlantModel? result = await PlantsService.addNewPlant(
          PlantModel(
            name: _nameController.text,
            species: _speciesController.text,
            imageUrls:
                _imageUrl != null
                    ? <String?>[_imageUrl]
                    : [], // Implement image Url
            archived: false,
            wateringReminderEnabled: _wateringReminderEnabled,
            waterIntervalDays:
                _wateringReminderEnabled
                    ? int.tryParse(_wateringIntervalController.text)
                    : null,
            lastWateredAt:
                _wateringReminderEnabled ? _lastWateredAt.toString() : null,
            waterAmount: _wateringReminderEnabled ? _waterAmount : null,
            fertilizerReminderEnabled: _fertilizerReminderEnabled,
            fertilizerIntervalDays:
                _fertilizerReminderEnabled
                    ? int.tryParse(_fertilizerIntervalController.text)
                    : null,
            lastFertilizedAt:
                _fertilizerReminderEnabled
                    ? _lastFertilizedAt.toString()
                    : null,
            humidityPreference: _humidityPreference.toString(),
            location: _locationController.text,
            notes: _notes,
            soilType: _soilTypeController.text,
            sunlightPreference: _sunlightPreference.toString(),
            tags: _tags,
            userId: UserStateController.user.value.userId!,
          ),
        );

        AppStateController.setLoadingState(false);
        if (result != null) {
          // TODO(RV): Add success toast
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

  Form _buildAddPlantForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: <Widget>[
            // Image upload box
            ImageBox(
              onTap: () {
                // TODO(RV): Add logic
                // 1. open camera to capture photo
                // 2. store locally until record is saved
                setState(() {
                  // 3. Apply returned local url to `_imageUrl`
                });
              },
              imageUrl: _imageUrl,
            ),
            const SizedBox(height: 16.0),

            // Name field
            LaTextInputField(
              label: 'name'.tr,
              controller: _nameController,
              hintText: 'new-plant.name-hint'.tr,
              validator: (final dynamic val) {
                if (val == null || val == '') {
                  return 'new-plant.no-empty-name'.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Species field
            LaTextInputField(
              label: 'species'.tr,
              controller: _speciesController,
              hintText:
                  'e.g. "Chlorophytum comosum" or "African Lily"'
                      .tr, // TODO(RV): Add i18n strings
            ),
            const SizedBox(height: 16.0),

            // Location field
            LaTextInputField(
              label: 'location'.tr,
              controller: _locationController,
              hintText: 'new-plant.location-hint'.tr,
            ),
            const SizedBox(height: 16.0),

            // Watering reminder checkbox
            LaReminderToggle(
              label: 'new-plant.watering-reminders'.tr,
              condition: _wateringReminderEnabled,
              onChanged: (final bool? val) {
                setState(() {
                  _wateringReminderEnabled = val ?? false;
                });
              },
            ),

            // Watering interval number picker, inactive unless reminder enabled
            LaNumberPicker(
              label: 'new-plant.watering-interval'.tr,
              condition: _wateringReminderEnabled,
              onDecrementPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(_wateringIntervalController.text) ?? 0;
                  if (currentValue > 0) {
                    currentValue--;
                    _wateringIntervalController.text = currentValue.toString();
                  }
                });
              },
              onIncrementPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(_wateringIntervalController.text) ?? 0;
                  if (currentValue < 365) {
                    currentValue++;
                    _wateringIntervalController.text = currentValue.toString();
                  }
                });
              },
              controller: _wateringIntervalController,
            ),

            // "Last watered" date picker, optional
            LaDatePicker(
              label: 'new-plant.last-watered'.tr,
              variable: _lastWateredAt,
              condition: _wateringReminderEnabled,
              onPressed: () async {
                final DateTime? date = await Get.dialog(
                  DatePickerDialog(
                    firstDate: DateTime.parse('2024-01-01'),
                    lastDate: DateTime.parse('2125-12-31'),
                  ),
                );

                if (date != null) {
                  setState(() {
                    _lastWateredAt = date;
                  });
                }
              },
            ),

            // TODO(RV): Add waterAmount field
            const SizedBox(height: 16.0),

            // Fertilizer reminder checkbox
            LaReminderToggle(
              label: 'new-plant.fertilizer-reminders'.tr,
              condition: _fertilizerReminderEnabled,
              onChanged: (final bool? val) {
                setState(() {
                  _fertilizerReminderEnabled = val ?? false;
                });
              },
            ),

            // Fertilizer interval number picker, inactive unless reminder enabled
            LaNumberPicker(
              label: 'new-plant.fertilizer-interval'.tr,
              condition: _fertilizerReminderEnabled,
              onDecrementPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(_fertilizerIntervalController.text) ?? 0;
                  if (currentValue > 0) {
                    currentValue--;
                    _fertilizerIntervalController.text =
                        currentValue.toString();
                  }
                });
              },
              onIncrementPressed: () {
                setState(() {
                  int currentValue =
                      int.tryParse(_fertilizerIntervalController.text) ?? 0;
                  if (currentValue < 365) {
                    currentValue++;
                    _fertilizerIntervalController.text =
                        currentValue.toString();
                  }
                });
              },
              controller: _fertilizerIntervalController,
            ),

            // "Last fertilized" date picker, optional
            LaDatePicker(
              label:
                  'Last fertilized (optional):'
                      .tr, // TODO(RV): Add i18n strings
              variable: _lastFertilizedAt,
              condition: _fertilizerReminderEnabled,
              onPressed: () async {
                final DateTime? date = await Get.dialog(
                  DatePickerDialog(
                    firstDate: DateTime.parse('2024-01-01'),
                    lastDate: DateTime.parse('2125-12-31'),
                  ),
                );

                print('Date: $date');
                if (date != null) {
                  setState(() {
                    _lastFertilizedAt = date;
                  });
                }
              },
            ),
            // TODO(RV): Add fertilizerAmount field?

            // TODO(RV): Add humidity preference 3-way picker

            // TODO(RV): Add sunlight preference 3-way picker

            // TODO(RV): Add soiltype input field

            // Notes field
            // TODO(RV): Add list view of added notes, "add" button
            const SizedBox(height: 16.0),
            NotesField(controller: _noteController, list: _notes),
            const SizedBox(height: 16.0),

            TagsField(
              list: _notes,
              controller: _tagController,
              tags: _tags,
              onPressed: () {
                setState(() {
                  if (_tags.contains(_tagController.text) ||
                      _tagController.text == '') {
                    return;
                  }
                  _tags.add(_tagController.text);
                });
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppTheme.backgroundColor(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: AppTheme.backgroundColor(),
              title: Text(
                'add-plant'.tr,
                style: TextStyle(fontSize: 40.0, color: AppColors.green),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              // floating: true,
              // pinned: true,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  _buildAddPlantForm(),
                  const SizedBox(height: 16.0),
                  SubmitButton(onSubmit: onSubmit),
                  const SizedBox(height: 8.0),
                  const CancelButton(),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/date_picker.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/image_box.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/la_preference_toggle.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/notes_field.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/number_picker.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/reminder_toggle.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/tags_field.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/text_input_field.dart';
import 'package:la_mobile/services/appwrite.service.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_button.dart';
import 'package:la_mobile/widgets/buttons/la_cancel_button.dart';
import 'package:la_mobile/widgets/dialogs/capture_photo.dialog.dart';
import 'package:la_mobile/widgets/dialogs/error_dialog.dart';
import 'package:la_mobile/widgets/dialogs/photo_source.dialog.dart';

enum PreferenceEnum { low, medium, high }

/// This page allows users to add a new plant to their collection, including name, reminders,
/// notes, image, and preferences. Images are uploaded to Appwrite and the returned public URL
/// is stored in the Postgres-backed database (via your backend API).
class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

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
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;

  PreferenceEnum? _humidityPreference;
  PreferenceEnum? _sunlightPreference;
  DateTime? _lastWateredAt;
  DateTime? _lastFertilizedAt;
  bool _wateringReminderEnabled = true;
  bool _fertilizerReminderEnabled = false;

  // Used to create a dynamic experience while processing completes
  bool _isUploading = false;

  double? _waterAmount;
  double? _fertilizerAmount;
  final List<String> _tags = <String>[];
  final List<String> _notes = <String>[];
  String? _imageUrl;
  XFile? _mediaFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _initCamera() async {
    // Obtain a list of the available cameras on the device.
    final List<CameraDescription> cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    final CameraDescription firstCamera = cameras.first;

    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void initState() {
    super.initState();
    _wateringIntervalController.text = '2';
    _fertilizerIntervalController.text = '7';
    _initCamera();
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
    _cameraController.dispose();

    super.dispose();
  }

  Future<void> _onImageButtonPressed(
    final ImageSource source, {
    required final BuildContext context,
  }) async {
    Future<void> _cameraAction() async {
      await Get.dialog(
        CapturePhotoDialog(
          controller: _cameraController,
          onPressed: () async {
            final XFile file = await _cameraController.takePicture();
            setState(() {
              _mediaFile = file;
            });
            Get.back();
          },
          cameraFuture: _initializeCameraControllerFuture,
        ),
      );

      if (_mediaFile != null) {
        Get.back();
      }
    }

    Future<void> _galleryAction() async {
      try {
        // Opens camera or gallery to pick a plant image
        final XFile? pickedFile = await _picker.pickImage(source: source);
        setState(() {
          _mediaFile = pickedFile;
        });
      } on Exception catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }

      // onPick();
      Get.back();
    }

    if (context.mounted) {
      await Get.dialog(
        PhotoSourceDialog(
          cameraAction: _cameraAction,
          galleryAction: _galleryAction,
        ),
      );
    }
  }

  Future<void> _onSubmit() async {
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

      if (_mediaFile != null) {
        // Show loading spinner while uploading
        setState(() => _isUploading = true);

        _imageUrl = await AppWriteService().uploadImage(_mediaFile!);
        // _imageUrl = await AppWriteService.uploadImage(_mediaFile!);
      }

      if (_formValid) {
        final PlantModel? result = await PlantsService().addNewPlant(
          PlantModel(
            name: _nameController.text,
            species: _speciesController.text,
            imageUrls: _imageUrl != null ? <String?>[_imageUrl] : <void>[],
            archived: false,
            wateringReminderEnabled: _wateringReminderEnabled,
            waterIntervalDays:
                _wateringReminderEnabled
                    ? int.tryParse(_wateringIntervalController.text)
                    : null,
            lastWateredAt:
                _wateringReminderEnabled ? _lastWateredAt.toString() : null,
            waterAmount: _wateringReminderEnabled ? _waterAmount : null,
            fertilizerAmount:
                _wateringReminderEnabled ? _fertilizerAmount : null,
            fertilizerReminderEnabled: _fertilizerReminderEnabled,
            fertilizerIntervalDays:
                _fertilizerReminderEnabled
                    ? int.tryParse(_fertilizerIntervalController.text)
                    : null,
            lastFertilizedAt:
                _fertilizerReminderEnabled
                    ? _lastFertilizedAt.toString()
                    : null,
            humidityPreference:
                _humidityPreference != null
                    ? EnumToString.convertToString(_humidityPreference)
                    : null,
            location: _locationController.text,
            notes: _notes,
            soilType: _soilTypeController.text,
            sunlightPreference:
                _sunlightPreference != null
                    ? EnumToString.convertToString(_sunlightPreference)
                    : null,
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
        setState(() => _isUploading = false);
      }
    } on Exception catch (e) {
      debugPrint(
        'Failed to create new plant record'.tr, // TODO(RV): Add i18n strings
      );
      print(e);
    }
  }

  Future<void> _retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _mediaFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppTheme.backgroundColor(),
        body: SizedBox(
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: AppTheme.backgroundColor(),
                  title: Text(
                    'add-plant'.tr,
                    style: TextStyle(fontSize: 40.0, color: AppColors.green),
                  ),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                ),
                Column(
                  children: <Widget>[
                    //# New plant form
                    _buildAddPlantForm(),
                    const SizedBox(height: 16.0),

                    //# Submit button
                    LaButton(action: _onSubmit, label: 'submit'.tr),
                    const SizedBox(height: 8.0),

                    //# Cancel button
                    const LaCancelButton(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddPlantForm() {
    return _isUploading
        ? CircularProgressIndicator()
        : Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: <Widget>[
                //# Image upload box
                FutureBuilder<void>(
                  future: _retrieveLostData(),
                  builder: (
                    final BuildContext _,
                    final AsyncSnapshot<void> snapshot,
                  ) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return ImageBox(
                          onTap:
                              () => _onImageButtonPressed(
                                ImageSource.gallery,
                                context: context,
                              ),
                          mediaFile: _mediaFile,
                        );
                      case ConnectionState.done:
                        return _previewImage();
                      case ConnectionState.active:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image/video error: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return ImageBox(
                            onTap:
                                () => _onImageButtonPressed(
                                  ImageSource.gallery,
                                  context: context,
                                ),
                            mediaFile: _mediaFile,
                          );
                        }
                    }
                  },
                ),
                const SizedBox(height: 16.0),

                //# Name field
                LaTextInputField(
                  label: 'name'.tr, // TODO(RV): Add i18n strings
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

                //# Species field
                LaTextInputField(
                  label: 'species'.tr, // TODO(RV): Add i18n strings
                  controller: _speciesController,
                  hintText:
                      'e.g. "Chlorophytum comosum" or "African Lily"'
                          .tr, // TODO(RV): Add i18n strings
                ),
                const SizedBox(height: 16.0),

                //# Location field
                LaTextInputField(
                  label: 'location'.tr, // TODO(RV): Add i18n strings
                  controller: _locationController,
                  hintText: 'new-plant.location-hint'.tr,
                ),
                const SizedBox(height: 16.0),

                //# Watering reminder checkbox
                LaReminderToggle(
                  label: 'new-plant.watering-reminders'.tr,
                  condition: _wateringReminderEnabled,
                  onChanged: (final bool? val) {
                    setState(() {
                      _wateringReminderEnabled = val ?? false;
                    });
                  },
                ),

                //# Watering interval number picker, inactive unless reminder enabled
                LaNumberPicker(
                  label: 'new-plant.watering-interval'.tr,
                  condition: _wateringReminderEnabled,
                  onDecrementPressed: () {
                    setState(() {
                      int currentValue =
                          int.tryParse(_wateringIntervalController.text) ?? 0;
                      if (currentValue > 0) {
                        currentValue--;
                        _wateringIntervalController.text =
                            currentValue.toString();
                      }
                    });
                  },
                  onIncrementPressed: () {
                    setState(() {
                      int currentValue =
                          int.tryParse(_wateringIntervalController.text) ?? 0;
                      if (currentValue < 365) {
                        currentValue++;
                        _wateringIntervalController.text =
                            currentValue.toString();
                      }
                    });
                  },
                  controller: _wateringIntervalController,
                ),

                //# "Last watered" date picker, optional
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
                const SizedBox(height: 16.0),

                // TODO(RV): Add waterAmount field?

                //# Fertilizer reminder checkbox
                LaReminderToggle(
                  label: 'new-plant.fertilizer-reminders'.tr,
                  condition: _fertilizerReminderEnabled,
                  onChanged: (final bool? val) {
                    setState(() {
                      _fertilizerReminderEnabled = val ?? false;
                    });
                  },
                ),

                //# Fertilizer interval number picker, inactive unless reminder enabled
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

                //# "Last fertilized" date picker, optional
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

                    // print('Date: $date');
                    if (date != null) {
                      setState(() {
                        _lastFertilizedAt = date;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),

                // TODO(RV): Add fertilizerAmount field

                //# Soil type field
                LaTextInputField(
                  label: 'soil type'.tr,
                  controller: _soilTypeController,
                  hintText: 'e.g. rocky, or loam',
                ),

                //# Humidity preference 3-way switch
                LaPreferenceToggle(
                  onToggle: (final int? index) {
                    switch (index) {
                      case 0:
                        _humidityPreference = PreferenceEnum.low;
                        break;
                      case 1:
                        _humidityPreference = PreferenceEnum.medium;
                        break;
                      case 2:
                        _humidityPreference = PreferenceEnum.high;
                        break;
                    }
                  },
                  label: 'Humidity Preference'.tr, // TODO(RV): Add i18n strings
                ),
                const SizedBox(height: 16.0),

                //# Sunlight preference 3-way switch
                LaPreferenceToggle(
                  onToggle: (final int? index) {
                    switch (index) {
                      case 0:
                        _sunlightPreference = PreferenceEnum.low;
                        break;
                      case 1:
                        _sunlightPreference = PreferenceEnum.medium;
                        break;
                      case 2:
                        _sunlightPreference = PreferenceEnum.high;
                        break;
                    }
                  },
                  label: 'Sunlight Preference'.tr, // TODO(RV): Add i18n strings
                ),
                const SizedBox(height: 24.0),

                // TODO(RV): Add soiltype input field?

                //# Notes field
                NotesField(
                  controller: _noteController,
                  notes: _notes,
                  onPressed: () {
                    setState(() {
                      if (_notes.contains(_noteController.text) ||
                          _noteController.text == '') {
                        return;
                      }
                      _notes.add(_noteController.text);
                    });
                  },
                ),
                const SizedBox(height: 8.0),

                TagsField(
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

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_mediaFile != null) {
      return ImageBox(
        onTap:
            () => _onImageButtonPressed(ImageSource.gallery, context: context),
        mediaFile: _mediaFile,
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError', // TODO(RV): Add i18n strings
        textAlign: TextAlign.center,
      );
    } else {
      return ImageBox(
        onTap:
            () => _onImageButtonPressed(ImageSource.gallery, context: context),
        mediaFile: _mediaFile,
      );
    }
  }
}

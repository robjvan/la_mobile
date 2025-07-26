import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/utilities/theme.dart';
// import 'package:camera/camera.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:la_mobile/pages/add_plant_page/widgets/image_box.dart';
// import 'package:la_mobile/widgets/dialogs/capture_photo.dialog.dart';

class PlantDetailsPage extends StatefulWidget {
  final PlantModel plant;
  const PlantDetailsPage(this.plant, {super.key});

  @override
  State<PlantDetailsPage> createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends State<PlantDetailsPage> {
  // late CameraController _cameraController;
  // late Future<void> _initializeCameraControllerFuture;
  // String? _imageUrl;
  // XFile? _mediaFile;
  // dynamic _pickImageError;
  // String? _retrieveDataError;
  // final ImagePicker _picker = ImagePicker();

  // Future<void> _initCamera() async {
  //   // Obtain a list of the available cameras on the device.
  //   final List<CameraDescription> cameras = await availableCameras();
  //   // Get a specific camera from the list of available cameras.
  //   final CameraDescription firstCamera = cameras.first;

  //   _cameraController = CameraController(
  //     // Get a specific camera from the list of available cameras.
  //     firstCamera,
  //     // Define the resolution to use.
  //     ResolutionPreset.medium,
  //   );

  //   // Next, initialize the controller. This returns a Future.
  //   _initializeCameraControllerFuture = _cameraController.initialize();
  // }

  // Future<void> _retrieveLostData() async {
  //   final LostDataResponse response = await _picker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     setState(() {
  //       _mediaFile = response.file;
  //     });
  //   } else {
  //     _retrieveDataError = response.exception!.code;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _initCamera();
  }

  @override
  void dispose() {
    // Dispose of our text controllers
    // _nameController.dispose();
    // _speciesController.dispose();
    // _locationController.dispose();
    // _noteController.dispose();
    // _soilTypeController.dispose();
    // _wateringIntervalController.dispose();
    // _fertilizerIntervalController.dispose();
    // _cameraController.dispose();

    super.dispose();
  }

  // Future<void> _onImageButtonPressed(
  //   final ImageSource source, {
  //   required final BuildContext context,
  // }) async {
  //   Future<void> _cameraAction() async {
  //     await Get.dialog(
  //       CapturePhotoDialog(
  //         controller: _cameraController,
  //         onPressed: () async {
  //           final XFile file = await _cameraController.takePicture();
  //           setState(() {
  //             _mediaFile = file;
  //           });
  //           Get.back();
  //         },
  //         cameraFuture: _initializeCameraControllerFuture,
  //       ),
  //     );

  //     if (_mediaFile != null) {
  //       Get.back();
  //     }
  //   }

  //   Future<void> _galleryAction() async {
  //     try {
  //       // Opens camera or gallery to pick a plant image
  //       final XFile? pickedFile = await _picker.pickImage(source: source);
  //       setState(() {
  //         _mediaFile = pickedFile;
  //       });
  //     } on Exception catch (e) {
  //       setState(() {
  //         _pickImageError = e;
  //       });
  //     }

  //     // onPick();
  //     Get.back();
  //   }

  //   if (context.mounted) {
  //     await Get.dialog(
  //       PhotoSourceDialog(
  //         cameraAction: _cameraAction,
  //         galleryAction: _galleryAction,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: SafeArea(
          child: SizedBox(
            width: Get.width,
            child: Column(
              children: <Widget>[
                // Image Box
                Container(
                  height: Get.width * 0.8,
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.all(32.0),
                  child: Card(
                    elevation: 4,
                    color: AppColors.bgColorLightMode,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child:
                          widget.plant.imageUrls!.isNotEmpty
                              ? CachedNetworkImage(
                                imageUrl: widget.plant.imageUrls![0],
                                fit: BoxFit.cover,
                              )
                              : Image.asset(
                                'assets/images/image_placeholder.png',
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                ),
                //# Name field
                Text(
                  widget.plant.name?.capitalize ?? '',
                  style: TextStyle(
                    color: AppColors.textColorLightMode,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.plant.species!.isNotEmpty ? widget.plant.species! : '',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),

                // //# Image upload box
                // FutureBuilder<void>(
                //   future: _retrieveLostData(),
                //   builder: (
                //     final BuildContext _,
                //     final AsyncSnapshot<void> snapshot,
                //   ) {
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.none:
                //       case ConnectionState.waiting:
                //         return ImageBox(
                //           onTap:
                //               () => _onImageButtonPressed(
                //                 ImageSource.gallery,
                //                 context: context,
                //               ),
                //           mediaFile: _mediaFile,
                //         );
                //       case ConnectionState.done:
                //         return _previewImage();
                //       case ConnectionState.active:
                //         if (snapshot.hasError) {
                //           return Text(
                //             'Pick image/video error: ${snapshot.error}}',
                //             textAlign: TextAlign.center,
                //           );
                //         } else {
                //           return ImageBox(
                //             onTap:
                //                 () => _onImageButtonPressed(
                //                   ImageSource.gallery,
                //                   context: context,
                //                 ),
                //             mediaFile: _mediaFile,
                //           );
                //         }
                //     }
                //   },
                // ),
                const SizedBox(height: 16.0),

                // LaTextInputField(
                //   label: 'new-plant.name'.tr,
                //   controller: _nameController,
                //   hintText: 'new-plant.name-hint'.tr,
                //   validator: (final dynamic val) {
                //     if (val == null || val == '') {
                //       return 'new-plant.no-empty-name'.tr;
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Text? _getRetrieveErrorWidget() {
  //   if (_retrieveDataError != null) {
  //     final Text result = Text(_retrieveDataError!);
  //     _retrieveDataError = null;
  //     return result;
  //   }
  //   return null;
  // }

  // Widget _previewImage() {
  //   final Text? retrieveError = _getRetrieveErrorWidget();
  //   if (retrieveError != null) {
  //     return retrieveError;
  //   }
  //   if (_mediaFile != null) {
  //     return ImageBox(
  //       onTap:
  //           () => _onImageButtonPressed(ImageSource.gallery, context: context),
  //       mediaFile: _mediaFile,
  //     );
  //   } else if (_pickImageError != null) {
  //     return Text(
  //       'Pick image error: $_pickImageError', // TODO(RV): Add i18n strings
  //       textAlign: TextAlign.center,
  //     );
  //   } else {
  //     return ImageBox(
  //       onTap:
  //           () => _onImageButtonPressed(ImageSource.gallery, context: context),
  //       mediaFile: _mediaFile,
  //     );
  //   }
  // }
}

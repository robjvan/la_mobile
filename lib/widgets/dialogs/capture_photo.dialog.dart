import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/utilities/theme.dart';

class CapturePhotoDialog extends StatelessWidget {
  final CameraController controller;
  final Function() onPressed;
  final dynamic cameraFuture;
  const CapturePhotoDialog({
    required this.controller,
    required this.onPressed,
    required this.cameraFuture,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        FutureBuilder<void>(
          future: cameraFuture,
          builder: (
            final BuildContext context,
            final AsyncSnapshot<void> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return SizedBox(
                height: Get.height / 2.5,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(50),
                    ),
                    backgroundColor: AppColors.green,
                    foregroundColor: AppColors.white,
                    onPressed: onPressed,
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                  body: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: CameraPreview(controller),
                    ),
                  ),
                ),
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

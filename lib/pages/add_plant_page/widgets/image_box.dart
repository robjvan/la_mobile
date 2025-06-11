// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageBox extends StatelessWidget {
  final Function() onTap;
  final XFile? mediaFile;
  const ImageBox({required this.onTap, this.mediaFile, super.key});

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          mediaFile == null
              ? Stack(
                children: <Widget>[
                  Center(
                    child: Card(
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          'assets/images/image_placeholder.png',
                          height: Get.width * 0.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'new-plant.upload-photo'.tr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
              : ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.file(
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                  File(mediaFile!.path),
                  errorBuilder: (
                    final BuildContext context,
                    final Object error,
                    final StackTrace? stackTrace,
                  ) {
                    return Center(
                      child: Text(
                        'This image type is not supported'
                            .tr, // TODO(RV): Add i18n strings
                      ),
                    );
                  },
                ),
              ),
    );
  }
}

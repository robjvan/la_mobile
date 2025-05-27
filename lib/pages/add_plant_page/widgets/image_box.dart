import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageBox extends StatelessWidget {
  final String? imageUrl;
  final Function()? onTap;
  const ImageBox({required this.onTap, this.imageUrl, super.key});

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// TODO(RV): Add logic to add a photo. Can we temporarily store it locally and upload it during the "onSubmit" process?
      },
      child:
          imageUrl == null
              ? SizedBox(
                child: Stack(
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
                ),
              )
              : CachedNetworkImage(
                imageUrl: imageUrl!,
                height: Get.width * 0.5,
                fit: BoxFit.cover,
              ),
    );
  }
}

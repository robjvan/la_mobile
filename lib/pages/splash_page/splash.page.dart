import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/services/network.service.dart';
import 'package:la_mobile/utilities/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isConnected = false;
  String message = 'splash.connecting'.tr;

  @override
  void initState() {
    super.initState();
    checkNetworkConnection();
  }

  Future<void> checkNetworkConnection() async {
    AppStateController.setLoadingState(true);

    final http.Response response =
        await NetworkService.checkNetworkConnection();

    if (response.statusCode == 200) {
      setState(() {
        message = 'splash.connected'.tr;
      });
      AppStateController.setLoadingState(false);

      unawaited(Get.offAllNamed(kLoginRouteName));
    } else {
      AppStateController.setLoadingState(false);
      setState(() {
        message = 'splash.connection-failed'.tr;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorLightMode,
      body: SizedBox(
        width: Get.width,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(tag: 'app-logo', child: Image.asset(kAppLogoPath)),
              Text(
                'app_title'.tr,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: AppColors.green),
              ),
              const SizedBox(height: 32),
              if (AppStateController.isLoading.value)
                Center(
                  child: SizedBox(
                    height: 32.0,
                    child: CircularProgressIndicator(color: AppColors.green),
                  ),
                ),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.green,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

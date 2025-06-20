import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:la_mobile/utilities/routes.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/utilities/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await GetStorage.init();

  /// Lock app in portrait orientation
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Launch the app
  runApp(MyApp());
}

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetMaterialApp(
      title: 'app_title'.tr,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: AppTheme.fallbackLocale,
      getPages: AppRoutes.getPages,
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

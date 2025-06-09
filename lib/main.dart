import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:la_mobile/secrets.dart';
import 'package:la_mobile/services/appwrite-service.dart';
import 'package:la_mobile/utilities/routes.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/utilities/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await GetStorage.init();

  // Initilize connection to AppWrite
  // final Client client = Client();
  // final Storage storage;

  // client
  //     .setEndpoint('https://appwrite.robjvan.ca/v1')
  //     .setProject(AppSecrets.appWriteProjectId)
  //     .setSelfSigned(
  //       status: true,
  //     ); // For self signed certificates, only use for development;

  // final Storage storage = Storage(client);

  /// Lock app in portrait orientation
  await SystemChrome.setPreferredOrientations([
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

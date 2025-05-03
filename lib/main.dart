import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

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
  @override
  Widget build(final BuildContext context) {
    return GetMaterialApp(
      title: 'app_title'.tr,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: AppRoutes.getPages,
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:get/get_rx/get_rx.dart';

class AppStateController {
  static RxBool isLoading = false.obs;

  static RxBool useDarkMode = false.obs;

  static RxBool showFilterBar = false.obs;

  static RxBool viewAsList = false.obs;

  static void toggleDarkMode() {
    if (AppStateController.useDarkMode.value) {
      AppStateController.useDarkMode.value = false;
    } else {
      AppStateController.useDarkMode.value = true;
    }
  }

  static void toggleFilterBar() {
    if (AppStateController.showFilterBar.value) {
      AppStateController.showFilterBar.value = false;
    } else {
      AppStateController.showFilterBar.value = true;
    }
    print(AppStateController.showFilterBar.value);
  }

  static void toggleListView() {
    if (AppStateController.viewAsList.value) {
      AppStateController.viewAsList.value = false;
    } else {
      AppStateController.viewAsList.value = true;
    }
    print(AppStateController.viewAsList.value);
  }
}

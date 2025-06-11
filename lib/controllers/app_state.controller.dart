import 'package:get/get_rx/get_rx.dart';

class AppStateController {
  static RxBool isLoading = false.obs;

  static RxBool useDarkMode = false.obs;

  static RxBool showFilterBar = false.obs;

  static RxBool viewAsList = false.obs;

  static RxBool saveUsername = false.obs;

  static RxBool enableNotifications = false.obs;

  static RxString searchTerm = ''.obs;

  static void setLoadingState(final bool isLoading) =>
      AppStateController.isLoading.value = isLoading;

  static void toggleDarkMode() {
    AppStateController.useDarkMode.value =
        !AppStateController.useDarkMode.value;
  }

  static void toggleNotifications() {
    AppStateController.enableNotifications.value =
        !AppStateController.enableNotifications.value;
  }

  static void toggleFilterBar() {
    AppStateController.showFilterBar.value =
        !AppStateController.showFilterBar.value;
  }

  static void toggleListView() {
    AppStateController.viewAsList.value = !AppStateController.viewAsList.value;
  }

  static void clearSearchTerm() {
    AppStateController.searchTerm.value = '';
  }
}

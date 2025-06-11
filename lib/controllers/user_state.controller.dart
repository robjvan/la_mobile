import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/models/user.model.dart';
import 'package:la_mobile/services/plants.service.dart';

class UserStateController {
  static Rx<UserModel> user = UserModel.initial().obs;

  static RxList<PlantModel> userPlants = <PlantModel>[].obs;

  static RxString username = ''.obs;

  static void setUserData(final UserModel user) =>
      UserStateController.user.value = user;

  static void setUserPlants(final List<PlantModel> plants) =>
      UserStateController.userPlants.value = plants;

  static void clearUser() {
    UserStateController.user.value = UserModel.initial();
  }

  static void logout() {
    UserStateController.clearUser();
    PlantsService().clearPlants();

    Get.offAllNamed(kLoginRouteName);
  }
}

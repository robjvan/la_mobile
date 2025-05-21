import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/plants.controller.dart';
import 'package:la_mobile/models/user.model.dart';

class UserController {
  // UserController class definition
  // This class will handle user-related operations
  // such as fetching user data, updating user information, etc.

  static Rx<UserModel> user = UserModel.initial().obs;

  static void setUserData(final UserModel user) =>
      UserController.user.value = user;

  static void clearUser() {
    UserController.user.value = UserModel.initial();
  }

  static void logout() {
    UserController.clearUser();
    PlantsController.clearPlants();

    Get.offAllNamed(kLoginRouteName);
  }
}

import 'package:get/get.dart';
import 'package:la_mobile/models/user.model.dart';

class UserController {
  // UserController class definition
  // This class will handle user-related operations
  // such as fetching user data, updating user information, etc.

  static Rx<UserModel> user = UserModel.initial().obs;

  static void setUserData(final UserModel user) =>
      UserController.user.value = user;

  // Example method to fetch user data
  static void fetchUserData() {
    // Logic to fetch user data
  }

  // Example method to update user information
  static void updateUserInfo() {
    // Logic to update user information
  }

  static void clearUser() {
    UserController.user.value = UserModel.initial();
  }
}

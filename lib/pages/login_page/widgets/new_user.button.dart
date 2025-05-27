import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class NewUserButton extends StatelessWidget {
  const NewUserButton({super.key});

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('register called');
            // TODO(RV): Add logic to register new user
          },
          child: Obx(
            () => Text(
              'login.register'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    AppStateController.useDarkMode.value
                        ? AppColors.textColorDarkMode
                        : AppColors.textColorLightMode,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

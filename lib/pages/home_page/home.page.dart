import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/pages/home_page/widgets/la_speed_dial.dart';
import 'package:la_mobile/pages/home_page/widgets/plant_grid_tile.dart';
import 'package:la_mobile/pages/home_page/widgets/plant_list_tile.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/la_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // Fetch user data - user, profile, plants, etc.
    PlantsService.fetchUserPlants();
  }

  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: LaSpeedDial(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarHeight),
          child: LaAppbar(title: 'dashboard'.tr),
        ),
        backgroundColor:
            AppStateController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 8.0),
                Obx(
                  () => Text(
                    'Hello ${UserStateController.user.value.username}', // TODO(RV): Add i18n strings
                    style: TextStyle(
                      fontSize: 24.0,
                      color:
                          AppStateController.useDarkMode.value
                              ? AppColors.textColorDarkMode
                              : AppColors.textColorLightMode,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () =>
                        AppStateController.isLoading.value
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 32.0,
                                  child: CircularProgressIndicator(
                                    color: AppColors.green,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Loading data...'
                                      .tr, // TODO(RV): Add i18n strings
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.italic,
                                    color:
                                        AppStateController.useDarkMode.value
                                            ? AppColors.textColorDarkMode
                                            : AppColors.textColorLightMode,
                                  ),
                                ),
                              ],
                            )
                            : AppStateController.viewAsList.value
                            ? ListView.builder(
                              itemCount: UserStateController.userPlants.length,
                              shrinkWrap: true,
                              itemBuilder: (final _, final int index) {
                                return PlantListTile(
                                  UserStateController.userPlants[index],
                                );
                              },
                            )
                            : GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              shrinkWrap: true,
                              itemCount: UserStateController.userPlants.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4.0,
                                  ),
                              itemBuilder: (final _, final int index) {
                                return PlantGridTile(
                                  UserStateController.userPlants[index],
                                );
                              },
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/plants.controller.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/controllers/user.controller.dart';
import 'package:la_mobile/pages/home_page/widgets/plant_grid_tile.dart';
import 'package:la_mobile/pages/home_page/widgets/plant_ilst_tile.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/buttons/la_speed_dial.dart';
import 'package:la_mobile/widgets/la_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(final BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: LaSpeedDial(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarHeight),
          child: LaAppbar(title: 'Dashboard'),
        ),
        backgroundColor:
            SettingsController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        body: SizedBox(
          width: Get.width,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 8.0),
                Obx(
                  () => Text(
                    'Hello ${UserController.user.value.username}',
                    style: TextStyle(
                      fontSize: 24.0,
                      color:
                          SettingsController.useDarkMode.value
                              ? AppColors.textColorDarkMode
                              : AppColors.textColorLightMode,
                    ),
                  ),
                ),
                Obx(
                  () =>
                      SettingsController.viewAsList.value
                          ? ListView.builder(
                            itemCount: PlantsController.userPlants.length,
                            shrinkWrap: true,
                            itemBuilder: (final _, final int index) {
                              return PlantListTile(
                                PlantsController.userPlants[index],
                              );
                            },
                          )
                          : GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            shrinkWrap: true,
                            itemCount: PlantsController.userPlants.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4.0,
                                ),
                            itemBuilder: (final _, final int index) {
                              return PlantGridTile(
                                PlantsController.userPlants[index],
                              );
                            },
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

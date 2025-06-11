import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/controllers/user_state.controller.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/pages/home_page/widgets/plant_grid_tile.dart';
import 'package:la_mobile/pages/home_page/widgets/plant_list_tile.dart';
import 'package:la_mobile/pages/home_page/widgets/search_bar.dart';
import 'package:la_mobile/services/plants.service.dart';
import 'package:la_mobile/utilities/theme.dart';
import 'package:la_mobile/widgets/la_appbar.dart';
import 'package:la_mobile/widgets/la_speed_dial.dart';

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
    PlantsService().fetchUserPlants();
  }

  LaSearchBar _buildHeader() {
    return LaSearchBar();
  }

  Column _buildLoadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 32.0,
          child: CircularProgressIndicator(color: AppColors.green),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Loading data...'.tr, // TODO(RV): Add i18n strings
          style: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            color: AppTheme.textColor(),
          ),
        ),
      ],
    );
  }

  List<PlantModel> _buildPlantsList() {
    if (AppStateController.searchTerm.value == '') {
      return UserStateController.userPlants;
    } else {
      final String cleanedSearchTerm =
          AppStateController.searchTerm.value.toLowerCase();

      return UserStateController.userPlants.where((final PlantModel p) {
        if (p.name != null) {
          final String cleanedName = p.name!.toLowerCase();
          if (cleanedName.contains(cleanedSearchTerm)) return true;
        }

        if (p.location != null) {
          final String cleanedLocation = p.location!.toLowerCase();
          if (cleanedLocation.contains(cleanedSearchTerm)) return true;
        }

        if (p.notes != null && p.notes!.isNotEmpty) {
          p.notes!.map((final dynamic note) {
            if (note.toLowercase().contains(cleanedSearchTerm)) return true;
          });
        }

        if (p.tags != null && p.tags!.isNotEmpty) {
          p.tags!.map((final dynamic tag) {
            if (tag.toLowercase().contains(cleanedSearchTerm)) return true;
          });
        }

        return false;
      }).toList();
    }
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _buildPlantsList().length,
      shrinkWrap: true,
      itemBuilder: (final _, final int index) {
        return PlantListTile(_buildPlantsList()[index]);
      },
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shrinkWrap: true,
      itemCount: _buildPlantsList().length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (final _, final int index) {
        return PlantGridTile(_buildPlantsList()[index]);
      },
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      floatingActionButton: LaSpeedDial(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarHeight),
        child: LaAppbar(title: 'dashboard'.tr),
      ),
      backgroundColor: AppTheme.backgroundColor(),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 8.0),
                if (AppStateController.showFilterBar.value) _buildHeader(),
                Expanded(
                  child: Obx(
                    () =>
                        AppStateController.isLoading.value
                            ? _buildLoadingWidget()
                            : AppStateController.viewAsList.value
                            ? _buildListView()
                            : _buildGridView(),
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

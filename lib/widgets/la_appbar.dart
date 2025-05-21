import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/settings.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaAppbar extends StatefulWidget {
  final String title;
  const LaAppbar({required this.title, super.key});

  @override
  State<LaAppbar> createState() => _LaAppbarState();
}

class _LaAppbarState extends State<LaAppbar> {
  @override
  Widget build(final BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kAppBarHeight),
      child: AppBar(
        backgroundColor:
            SettingsController.useDarkMode.value
                ? AppColors.bgColorDarkMode
                : AppColors.bgColorLightMode,
        foregroundColor:
            SettingsController.useDarkMode.value
                ? AppColors.textColorDarkMode
                : AppColors.textColorLightMode,
        leading: Image.asset('assets/logo/logo.png'),
        title: Text(widget.title),
        actions: <Widget>[
          Obx(
            () => IconButton(
              icon: Icon(
                SettingsController.viewAsList.value
                    ? Icons.view_list
                    : Icons.apps,
              ),
              onPressed: SettingsController.toggleListView,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                SettingsController.showFilterBar.value
                    ? Icons.search_off
                    : Icons.search,
              ),
              onPressed: SettingsController.toggleFilterBar,
            ),
          ),
        ],
      ),
    );
  }
}

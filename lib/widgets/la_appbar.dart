import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/constants.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
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
        backgroundColor: AppTheme.backgroundColor(),
        foregroundColor: AppTheme.textColor(),
        leading: Image.asset('assets/logo/logo.png'),
        title: Text(widget.title),
        actions: <Widget>[
          Obx(
            () => IconButton(
              icon: Icon(
                AppStateController.viewAsList.value
                    ? Icons.view_list
                    : Icons.apps,
              ),
              onPressed: AppStateController.toggleListView,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                AppStateController.showFilterBar.value
                    ? Icons.search_off
                    : Icons.search,
              ),
              onPressed: AppStateController.toggleFilterBar,
            ),
          ),
        ],
      ),
    );
  }
}

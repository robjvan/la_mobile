import 'package:flutter/material.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaSearchBar extends StatefulWidget {
  const LaSearchBar({super.key});

  @override
  State<LaSearchBar> createState() => _LaSearchBarState();
}

class _LaSearchBarState extends State<LaSearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchController.text = AppStateController.searchTerm.value;
  }

  void _onSubmit(final String? val) {
    if (val != null) {
      AppStateController.searchTerm.value = val;
    }
  }

  void _clearSearchTerm() {
    searchController.text = '';
    AppStateController.clearSearchTerm();
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SearchBar(
        onChanged: _onSubmit,
        onSubmitted: _onSubmit,
        controller: searchController,
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              color:
                  AppStateController.useDarkMode.value
                      ? AppColors.green
                      : AppColors.bgColorDarkMode,
              width: AppStateController.useDarkMode.value ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        elevation: WidgetStatePropertyAll<double>(0),
        backgroundColor: WidgetStatePropertyAll<Color>(
          AppTheme.backgroundColor(),
        ),
        trailing: <Widget>[
          IconButton(
            onPressed: _clearSearchTerm,
            icon: Icon(Icons.clear, color: AppTheme.textColor()),
          ),
        ],
        textStyle: WidgetStatePropertyAll<TextStyle>(
          TextStyle(color: AppTheme.textColor()),
        ),
      ),
    );
  }
}

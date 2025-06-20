import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

final RegExp numberReg = RegExp(r'\d');

class MetricsCard extends StatelessWidget {
  final String label;
  final String value;

  const MetricsCard(this.label, this.value, {super.key});

  Widget _buildHeader() {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor(),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildValue() {
    return SizedBox(
      height: 48.0,
      child: Center(
        child: Text(
          value != ''
              ? value.substring(0, 1).toUpperCase() + value.substring(1)
              : '',
          style: TextStyle(
            fontSize:
                numberReg.hasMatch(value)
                    ? 36.0
                    : value.length > 6
                    ? 18.0
                    : 24.0,
            color:
                AppStateController.useDarkMode.value
                    ? AppColors.limeGreen
                    : AppColors.textColorLightMode,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Card(
      color:
          AppStateController.useDarkMode.value
              ? Color(0xFF212121)
              : AppColors.bgColorLightMode,
      child: Container(
        width: (Get.width / 3) - 16,
        padding: const EdgeInsets.all(8.0),
        height: 120,
        child: Column(
          children: <Widget>[
            const Spacer(),
            _buildHeader(),
            const Spacer(),
            _buildValue(),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

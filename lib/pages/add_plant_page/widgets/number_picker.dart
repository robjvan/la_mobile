import 'package:flutter/material.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaNumberPicker extends StatelessWidget {
  final String label;
  final bool condition;
  final Function() onDecrementPressed;
  final Function() onIncrementPressed;
  final TextEditingController controller;

  const LaNumberPicker({
    required this.label,
    required this.condition,
    required this.onDecrementPressed,
    required this.onIncrementPressed,
    required this.controller,
    super.key,
  });

  Widget _buildDecrementButton() {
    return SizedBox(
      width: 32.0,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: condition ? onDecrementPressed : null,
        child: Text(
          '-',
          style: TextStyle(
            fontSize: 24.0,
            color:
                condition
                    ? AppTheme.textColor()
                    : AppStateController.useDarkMode.value
                    ? AppColors.grey
                    : AppColors.lightGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildValueBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 24.0,
        child: Text(
          controller.text,
          style: TextStyle(
            fontSize: 18.0,
            color:
                condition
                    ? AppTheme.textColor()
                    : AppStateController.useDarkMode.value
                    ? AppColors.grey
                    : AppColors.lightGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildIncrementButton() {
    return SizedBox(
      width: 32.0,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: condition ? onIncrementPressed : null,
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 16.0,
            color:
                condition
                    ? AppTheme.textColor()
                    : AppStateController.useDarkMode.value
                    ? AppColors.grey
                    : AppColors.lightGrey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: condition ? AppTheme.textColor() : AppColors.lightGrey,
            fontStyle: condition ? FontStyle.normal : FontStyle.italic,
          ),
        ),
        const Spacer(),
        _buildDecrementButton(),
        _buildValueBox(),
        _buildIncrementButton(),
        const SizedBox(width: 10.0),
      ],
    );
  }
}

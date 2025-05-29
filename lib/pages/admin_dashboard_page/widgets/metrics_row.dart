import 'package:flutter/material.dart';
import 'package:la_mobile/controllers/app_state.controller.dart';
import 'package:la_mobile/utilities/theme.dart';

class MetricsRow extends StatelessWidget {
  final String label;
  final List<dynamic> cards;
  const MetricsRow({required this.label, required this.cards, super.key});

  @override
  Widget build(final BuildContext context) {
    return Card(
      elevation: 4,
      color:
          AppStateController.useDarkMode.value
              ? Color(0xFF282828)
              : const Color(0xFFEEEEEE),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 28.0,
                color:
                    AppStateController.useDarkMode.value
                        ? AppColors.limeGreen
                        : AppColors.textColorLightMode,
              ),
            ),
            const SizedBox(height: 8.0),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: cards.length,
              itemBuilder: (final BuildContext context, final int i) {
                return cards[i];
              },
            ),
          ],
        ),
      ),
    );
  }
}

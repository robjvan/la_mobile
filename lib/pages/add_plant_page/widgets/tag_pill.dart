import 'package:flutter/material.dart';
import 'package:la_mobile/utilities/theme.dart';

class LaTagPill extends StatelessWidget {
  final String tag;
  final Function() onDelete;
  final bool small;
  const LaTagPill({
    required this.tag,
    required this.onDelete,
    this.small = true,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.green.withAlpha(160),
          shape: BoxShape.rectangle,
        ),
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 4.0,
          top: 4.0,
          bottom: 4.0,
        ),
        child: Row(
          children: <Widget>[
            Text(
              tag,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.white),
            ),
            const SizedBox(width: 8.0),
            if (!small) Spacer(),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                Icons.cancel_rounded,
                color: AppColors.bgColorLightMode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitButton extends StatelessWidget {
  final Function() onSubmit;
  const SubmitButton({required this.onSubmit, super.key});

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton(onPressed: onSubmit, child: Text('submit'.tr));
  }
}

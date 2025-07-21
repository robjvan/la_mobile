import 'package:flutter/material.dart';
import 'package:la_mobile/models/plant.model.dart';
import 'package:la_mobile/widgets/buttons/la_cancel_button.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final PlantModel plant;
  // final VoidCallback onConfirm;

  const DeleteConfirmDialog(this.plant, {super.key});

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Plant',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Are you sure you want to delete "${plant.name}"? This cannot be undone.',
      ),
      actions: [
        LaCancelButton(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            // Call backend to delete plant
            // Refresh user plant list
            // Get.back();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

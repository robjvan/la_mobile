import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/tag_pill.dart';
import 'package:la_mobile/utilities/theme.dart';

class NotesField extends StatefulWidget {
  final TextEditingController controller;
  final Function() onPressed;
  final List<String> notes;

  const NotesField({
    required this.controller,
    required this.onPressed,
    required this.notes,
    super.key,
  });

  @override
  State<NotesField> createState() => _NotesFieldState();
}

class _NotesFieldState extends State<NotesField> {
  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'notes'.tr,
          style: TextStyle(fontSize: 24.0, color: AppTheme.textColor()),
        ),
        TextFormField(
          onFieldSubmitted: (final _) => widget.onPressed(),
          controller: widget.controller,
          style: TextStyle(color: AppTheme.textColor()),
          validator: (final dynamic val) => null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: 'new-plant.notes-hint'.tr,
            hintStyle: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 2),
              borderRadius: BorderRadius.circular(16.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.add, color: AppTheme.textColor()),
              onPressed: widget.onPressed,
            ),
          ),
          autovalidateMode: AutovalidateMode.onUnfocus,
        ),
        if (widget.notes.isNotEmpty)
          SizedBox(
            width: Get.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.notes.length,
              padding: const EdgeInsets.only(top: 8),
              itemBuilder: (final BuildContext context, final int i) {
                return Column(
                  children: [
                    if (i != 0) const SizedBox(height: 4.0),
                    LaTagPill(
                      tag: widget.notes[i],
                      onDelete: () {
                        setState(() {
                          widget.notes.removeAt(i);
                        });
                      },
                      small: false,
                    ),
                  ],
                );
              },
            ),
          ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

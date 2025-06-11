import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_mobile/pages/add_plant_page/widgets/tag_pill.dart';
import 'package:la_mobile/utilities/theme.dart';

class TagsField extends StatefulWidget {
  final TextEditingController controller;
  final Function() onPressed;
  final List<String> tags;

  const TagsField({
    required this.controller,
    required this.onPressed,
    required this.tags,
    super.key,
  });

  @override
  State<TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  Widget _buildInputField() {
    return TextFormField(
      onFieldSubmitted: (final _) => widget.onPressed(),
      style: TextStyle(color: AppTheme.textColor()),
      controller: widget.controller,
      validator: (final dynamic val) => null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        hintText: 'new-plant.tags-hint'.tr,
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
    );
  }

  Widget _buildTagsList() {
    return SizedBox(
      width: Get.width,
      height: 32,
      child: ListView.builder(
        itemBuilder: (final BuildContext context, final int i) {
          return LaTagPill(
            tag: widget.tags[i],
            onDelete: () {
              setState(() {
                widget.tags.removeAt(i);
              });
            },
          );
        },
        shrinkWrap: true,
        itemCount: widget.tags.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text('tags'.tr, style: TextStyle(fontSize: 24.0)),
        _buildInputField(),
        const SizedBox(height: 8.0),
        if (widget.tags.isNotEmpty) _buildTagsList(),
      ],
    );
  }
}

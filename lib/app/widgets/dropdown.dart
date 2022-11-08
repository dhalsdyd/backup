import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:flutter/material.dart';

class FGBPDropdownMenu extends StatelessWidget {
  const FGBPDropdownMenu({
    Key? key,
    required this.hints,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final String hints;
  final int? value;
  final List<Category> items;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FGBPColors.White1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: DropdownButtonFormField(
            value: value,
            decoration: const InputDecoration(border: InputBorder.none),
            isExpanded: true,
            hint: Text(hints, style: FGBPTextTheme.text2),
            items: items.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
              );
            }).toList(),
            onChanged: onChanged),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yummy/constants.dart';

class ColorButton extends StatelessWidget {
  // 1
  const ColorButton({
    super.key,
    required this.changeColor,
    required this.colorSelected,
  });

  // 2
  final void Function(int) changeColor;
  final ColorSelection colorSelected;

  @override
  Widget build(BuildContext context) {
    // 3
    return PopupMenuButton(
      icon: const Icon(Icons.opacity_outlined),
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      itemBuilder: (context) {
        return List.generate(ColorSelection.values.length, (index) {
          final currentColor = ColorSelection.values[index];
          return PopupMenuItem(
              value: index,
              enabled: currentColor != colorSelected,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child:
                        Icon(Icons.opacity_outlined, color: currentColor.color),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(currentColor.label),
                  )
                ],
              ));
        });
      },
      onSelected: changeColor,
    );
  }
}

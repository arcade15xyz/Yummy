import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({required this.changeThemeMode, super.key});

  final Function changeThemeMode;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;

    return IconButton(
        onPressed: () => changeThemeMode(!isBright),
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined));
  }
}

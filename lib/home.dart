import 'package:flutter/material.dart';
import 'package:yummy/components/color_button.dart';
import 'package:yummy/components/theme_button.dart';
import 'package:yummy/constants.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.changeTheme,
      required this.changeColor,
      required this.colorSelected});

  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Todo track current tab

  // Todo Define tab bar destinations
  @override
  Widget build(BuildContext context) {
    //Todo define Pages

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
              changeColor: widget.changeColor,
              colorSelected: widget.colorSelected)
        ],
      ),
      //Todo: Switch between pages.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'You Hungry?😝',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      //Todo: Add bottom navigation bar
    );
  }
}

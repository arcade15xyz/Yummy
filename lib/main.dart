import 'package:flutter/material.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/home.dart';

void main() {
  runApp(Yummy());
}

class Yummy extends StatefulWidget {
  // TODO: Setup default theme
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;

  // TODO: Add changeTheme above here
  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  /// for changing the seed color
  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';
    return MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        // Uncomment to remove Debug banner

        themeMode: themeMode,
        theme: ThemeData(
            colorSchemeSeed: colorSelected.color, brightness: Brightness.light),
        darkTheme: ThemeData(
            colorSchemeSeed: colorSelected.color, brightness: Brightness.dark),
        // TODO: Replace Scaffold with Home widget
        home: Home(
            changeTheme: changeThemeMode,
            changeColor: changeColor,
            colorSelected: colorSelected));
  }
}

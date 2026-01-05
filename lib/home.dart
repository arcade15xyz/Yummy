import 'package:flutter/material.dart';
import 'package:yummy/components/category_card.dart';
import 'package:yummy/components/color_button.dart';
import 'package:yummy/components/post_card.dart';
import 'package:yummy/components/restaurant_landscape_card.dart';
import 'package:yummy/components/theme_button.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/models/food_category.dart';
import 'package:yummy/models/models.dart';

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
  int tab = 0;

  // Todo Define tab bar destinations
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Category',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Post',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Restaurant',
      selectedIcon: Icon(Icons.credit_card),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //Todo define Pages
    final pages = [
      //Todo: replace with category card
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: CategoryCard(category: categories[0]),
        ),
      ),
      //Todo: replace with Post card
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PostCard(post: posts[0]),
        ),
      ),
      //Todo: Replace with restaurant Landscape card
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: RestaurantLandscapeCard(
            restaurant: restaurants[0],
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          )
        ],
      ),
      //Todo: Switch between pages.
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Text(
      //     'You Hungry?😝',
      //     style: Theme.of(context).textTheme.displayLarge,
      //   ),
      // ),
      //Todo: Add bottom navigation bar
      bottomNavigationBar: NavigationBar(
        destinations: appBarDestinations,
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
      ),
    );
  }
}

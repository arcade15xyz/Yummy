import 'package:flutter/material.dart';
import 'package:yummy/models/food_category.dart';

class CategoryCard extends StatelessWidget {
  final FoodCategory category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    //Todo: Get text theme
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    //Todo: Replace with card widgets
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Todo: Add Stack Widget
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(category.imageUrl),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Text(
                  'Yummy',
                  style: textTheme.headlineLarge,
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Smoothies',
                    style: textTheme.headlineLarge,
                  ),
                ),
              )
            ],
          ),
          //Todo: Add ListTile widget
          ListTile(
            title: Text(
              category.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              '${category.numberOfRestaurants} places',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

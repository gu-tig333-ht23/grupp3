import 'package:flutter/material.dart';
import 'package:mealmate/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class EmptyCards extends StatelessWidget {
  const EmptyCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, value, child) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    'lib/images/avo_icon.png'), // Replace with the correct image path
                const SizedBox(
                    height: 16), // Add some spacing between the image and text
                const Text(
                  "We are out of recipes, would you like to refresh?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                    height: 16), // Add spacing between text and button
                IconButton(
                  icon: const Icon(Icons.refresh), iconSize: 60,
                  color: Colors.blue, // You can customize the icon
                  onPressed: () {
                    // Add your refresh functionality here
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

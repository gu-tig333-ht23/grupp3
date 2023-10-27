import 'package:flutter/material.dart';
import '/pages/home_page.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class EmptyCards extends StatelessWidget {
  const EmptyCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //AVOCADO IMAGE
            Image.asset('lib/images/avo_icon.png'),
            const SizedBox(height: 16),
            //TEXT
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "We are out of recipes, would you like to refresh?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
            const SizedBox(height: 16),
            //BUTTON
            IconButton(
              icon: const Icon(Icons.refresh),
              iconSize: 60,
              color: Colors.green,
              onPressed: () {
                //fetch new recipes from API
                Provider.of<RecipeProvider>(context, listen: false)
                    .fetchRandomRecipes();
                //refresh tinder cards
                Provider.of<RecipeProvider>(context, listen: false)
                    .refreshCards(false);
                //go back to widget that returns the new cards
                TinderOrEmptyWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}

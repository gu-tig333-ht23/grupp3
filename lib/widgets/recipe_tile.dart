// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../util/recipe_provider.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  RecipeTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                //name of recipe
                Text(
                  recipe.recipeName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                //view recipe
                ElevatedButton.icon(
                  onPressed: () {
                    //view recipe page
                    print('view recipe clicked');
                  },
                  icon: Icon(Icons.menu_book),
                  label: Text(
                    'View recipe',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ButtonStyle(),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    //pop up window??
                    print('add to mealplan clicked');
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    'Add to mealplan',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'lib/images/meal.png',
                  width: 100,
                  height: 100,
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    //delete recipe from my saved recipes
                    print('delete clicked');
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            )
          ],
          //image
        ),
      ),
    );
  }
}

//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import '../../util/recipe.dart';
import '../../pages/my_recipes_page.dart';
import 'recipe_chosen_mp.dart';

//Basic MealPlannerTile outline
class MealPlannerTile extends StatelessWidget {
  String dayOfWeek;
  Recipe? recipe;
  bool isRecipeChosen;

  MealPlannerTile({
    super.key,
    required this.dayOfWeek,
    required this.recipe,
    required this.isRecipeChosen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(2, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //veckodagen
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  //rektangeln, dekoration
                  child: Container(
                    height: 25,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(222, 241, 170, 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                Text(
                  dayOfWeek,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 3),

            showRecipeOrNot(isRecipeChosen, dayOfWeek, recipe, context),
          ],
        ),
      ),
    );
  }
}

//returns the inside of MealPlannerTile based on if there is a recipe chosen or not
Widget showRecipeOrNot(bool isRecipeChosen, String dayOfWeek, Recipe? recipe,
    BuildContext context) {
  return isRecipeChosen
      //RECIPE CHOSEN
      ? RecipeChosenMP(
          recipe: recipe!,
          dayOfWeek: dayOfWeek,
        )
      //NO RECIPE IS CHOSEN
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have not chosen a recipe for $dayOfWeek',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyRecipesPage()));
              },
              icon: Icon(Icons.add),
              label: Text(
                'Add recipe',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
}

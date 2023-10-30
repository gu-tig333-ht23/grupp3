//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import '/pages/view_recipe_page.dart';
import '/util/recipe.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

//INSIDE OF MEALPLANNER TILE, RECIPE IS CHOSEN
class RecipeChosenMP extends StatelessWidget {
  final String dayOfWeek;
  final Recipe recipe;
  const RecipeChosenMP(
      {super.key, required this.recipe, required this.dayOfWeek});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
        ),

        GestureDetector(
          child: Container(
            //IMAGE
            width: MediaQuery.of(context).size.width * 0.6,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.brown,
              image: DecorationImage(
                image: NetworkImage(recipe.image.toString()),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            //TITLE
            child: Center(
              child: Text(
                recipe.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          //NAVIGATE TO VIEWRECIPE PAGE WHEN IMAGE/TITLE IS CLICKED
          onTap: () async {
            // //fetch ingredients from api
            await context
                .read<RecipeProvider>()
                .fetchIngredientsFromApi(recipe);
            //go to view recipe page
            // ignore: use_build_context_synchronously
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ViewRecipePage(recipe: recipe);
                },
              ),
            );
          },
          onDoubleTap: () {
            //emtpy to prevent several API requests at once.
          },
        ),
        //REMOVE RECIPE FROM MEALPLANNER
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<RecipeProvider>(context, listen: false)
                .removePlannerItem(dayOfWeek);
          },
        ),
      ],
    );
  }
}

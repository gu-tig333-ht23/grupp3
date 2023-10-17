//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import '/pages/view_recipe_page.dart';
import '/util/recipe.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeChosenMP extends StatelessWidget {
  final String dayOfWeek;
  final Recipe? recipe;
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
            width: MediaQuery.of(context).size.width * 0.6,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.brown,
              image: DecorationImage(
                image: NetworkImage(recipe!.image.toString()),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Center(
              child: Text(
                recipe!.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ViewRecipePage(recipe: recipe!);
                },
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<RecipeProvider>(context, listen: false)
                .removePlannerItem(dayOfWeek, recipe!);
          },
        ),
      ],
    );
  }
}

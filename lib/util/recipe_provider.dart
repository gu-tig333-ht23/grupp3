// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Recipe {
  String recipeName;
  String cookTime;

  Recipe({required this.recipeName, required this.cookTime});
}

//CLASS FOR RECIPE CARD
/*class RecipeCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cooktime;
  final String thumbnailUrl;

  RecipeCard({
    required this.title,
    required this.rating,
    required this.cooktime,
    required this.thumbnailUrl,
  });
*/

class RecipeProvider extends ChangeNotifier {
  //list of recipe
  // ignore: prefer_final_fields
  List<Recipe> _recipeList = [
    Recipe(recipeName: 'Pasta carbonara', cookTime: '40 min'),
    Recipe(recipeName: 'Korv Stroganoff', cookTime: '20 min')
  ];

  //lägga till funktioner sen

  List<Recipe> get recipeList {
    return _recipeList;
  }
}

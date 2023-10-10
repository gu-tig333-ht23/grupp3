// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mealmate/util/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  //list of recipe
  // ignore: prefer_final_fields
  List<Recipe> _randomRecipeList = [
    Recipe(
        title: 'Pasta carbonara',
        readyInMinutes: 40,
        image: 'lib/images/avo_icon.png'),
    Recipe(
        title: 'Korv Stroganoff',
        readyInMinutes: 20,
        image: 'lib/images/meal.png')
  ];

  // ignore: prefer_final_fields
  List<Recipe> _myRecipeList = [];

  //lägga till ett recept i _myRecipeList
  String getImage(recipe) {
    return recipe.image;
  }

  void addToMyRecipes(recipe) {
    _myRecipeList.add(recipe);
    notifyListeners();
  }

  void removeFromMyRecipes(recipe) {
    _myRecipeList.remove(recipe);
    notifyListeners();
  }

  List<Recipe> get randomRecipeList {
    return _randomRecipeList;
  }

  List<Recipe> get myRecipeList {
    return _myRecipeList;
  }
}

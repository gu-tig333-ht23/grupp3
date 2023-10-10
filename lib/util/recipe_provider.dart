// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

//samma klass som i api men fipplar inte med den nu
class Recipe {
  final double? id;
  final String title;
  final String image;
  final int readyInMinutes;
  //final List<String> dishtypes;
  //final List expectedIngidients;

  Recipe({
    this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    //required this.dishtypes,
    //required this.expectedIngidients,
  });
}

class RecipeProvider extends ChangeNotifier {
  //list of recipe
  List<Recipe> _randomRecipeList = [];

  // ignore: prefer_final_fields
  List<Recipe> _myRecipeList = [
    Recipe(
        title: 'Pasta carbonara',
        readyInMinutes: 40,
        image: 'lib/images/avo_icon.png'),
    Recipe(
        title: 'Korv Stroganoff',
        readyInMinutes: 20,
        image: 'lib/images/meal.png')
  ];

  //lägga till ett recept i _myRecipeList
  String getImage(recipe) {
    return recipe.image.toString();
  }

  void addToMyRecipes(recipe) {
    _myRecipeList.add(recipe);
    notifyListeners();
  }

  List<Recipe> get randomRecipeList {
    return _randomRecipeList;
  }

  List<Recipe> get myRecipeList {
    return _myRecipeList;
  }
}

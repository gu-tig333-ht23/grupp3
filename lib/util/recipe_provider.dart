// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/util/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  //list of recipe
  // ignore: prefer_final_fields
  List<Recipe> _randomRecipeList = [
    Recipe(
      title: 'Pasta carbonara',
      readyInMinutes: 40,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Korv Stroganoff',
      readyInMinutes: 20,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Tacos',
      readyInMinutes: 10,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Ceasar Sallad',
      readyInMinutes: 10,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Pasta bolognaise',
      readyInMinutes: 30,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Dillfisk',
      readyInMinutes: 20,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Lasagne',
      readyInMinutes: 45,
      image: 'lib/images/stockfood.png',
    ),
    Recipe(
      title: 'Zuccinipasta',
      readyInMinutes: 10,
      image: 'lib/images/stockfood.png',
    ),
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

  String selectedDay = '';
  late Recipe mealPlannerRecipe;

  saveRecipeToMP(String chosenDay, chosenRecipe) {
    //här behöver vi nog göra ngt för att kunna visa valda receptet på vald dag??
    print(chosenDay);
    notifyListeners();
  }

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String selectTheDay(String weekday) {
    selectedDay = weekday;
    print('day is now $selectedDay');
    notifyListeners();
    return selectedDay;
  }

  List<String> get daysOfWeek => _daysOfWeek;

  bool _cardsAre = false;
  get cardsAre => _cardsAre;

  cardsAreEmpty(bool isEmpty) {
    _cardsAre = isEmpty;
    notifyListeners();
  }
}

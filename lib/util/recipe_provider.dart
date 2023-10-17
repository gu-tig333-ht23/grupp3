// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/util/api.dart';
import '/util/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  // API
  // Fetch recipe from API
  void fetchRandomRecipes() async {
    List<Recipe> recipes = await RecipeApi.getRandomRecipes();
    _randomRecipeList.addAll(recipes); // Add all fetched recipes to the list
    notifyListeners();
  }

  void fetchIngredients() async {
    var dataIng = await RecipeApi.getIngredients();
    print(dataIng);
    notifyListeners();
  }

  List<Recipe> _randomRecipeList = [];

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

  //för att titlar på de 7 korten ska finnas i MP
  String selectedDay = '';
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> get daysOfWeek => _daysOfWeek;
  String selectTheDay(String weekday) {
    selectedDay = weekday;
    print('day is now $selectedDay');
    notifyListeners();
    return selectedDay;
  }

//no more tinder for you
  bool _cardsAre = false;
  get cardsAre => _cardsAre;

  cardsAreEmpty(bool isEmpty) {
    _cardsAre = isEmpty;
    notifyListeners();
  }

  refreshCards(bool isEmpty) {
    _randomRecipeList.clear();
    _cardsAre = !_cardsAre;
    notifyListeners();
  }

//do shit
  void saveRecipeToMP(String chosenDay, Recipe chosenRecipe) {
    _plannerData[addPlannerItem(chosenDay, chosenRecipe)];
    notifyListeners();
  }

  final Map<String, Recipe?> _plannerData = {
    'Monday': null, //Monday
    'Tuesday': null,
    'Wednesday': null,
    'Thursday': null,
    'Friday': null,
    'Saturday': null,
    'Sunday': null,
  };

  Map<String, Recipe?> get plannerData => _plannerData;

  addPlannerItem(String day, Recipe item) {
    plannerData[day] = item;
    print(plannerData);
    notifyListeners();
  }

  removePlannerItem(String day, Recipe item) {
    plannerData[day] = null;
    print(plannerData);
    notifyListeners();
  }
}

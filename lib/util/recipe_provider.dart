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

//Dictionary för veckdodagar:
  final Map<String, int> _weekDays = {
    'Monday': 0,
    'Tuesday': 1,
    'Wednesday': 2,
    'Thursday': 3,
    'Friday': 4,
    'Saturday': 5,
    'Sunday': 6,
  };
//get/access dictionary
  Map<String, int> get weekDays => _weekDays;

  void saveRecipeToMP(int chosenDay, Recipe chosenRecipe) {
    //bara för print, tar bort senare :)
    String mealPlannerRecipe = chosenRecipe.title.toString();

    _plannerData[addPlannerItem(chosenDay, chosenRecipe)];

    print('$mealPlannerRecipe is chosen for $selectedDay');
    notifyListeners();
  }

  final Map<int, List<Recipe>> _plannerData = {
    0: [], //Monday
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
  };

  Map<int, List<Recipe>> get plannerData => _plannerData;

  addPlannerItem(int day, Recipe item) {
    plannerData[day]?.add(item);
    print(plannerData);
    notifyListeners();
  }
}

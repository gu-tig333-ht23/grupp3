// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/util/recipe_info.dart';
import '/util/api.dart';
import '/util/recipe.dart';
//import 'db.dart';

class RecipeProvider extends ChangeNotifier {
  // final DB _db;
  // List<Recipe> _recipes = [];
  // List<Recipe> get recipes => _recipes;

  // RecipeProvider(DB db) : _db = db;

  // //get recipes
  // void fetchRecipes() async {
  //   _myRecipeList = await _db.getRecipes();
  //   notifyListeners();
  // }

  // //add recipes
  // void addToMyRecipes(recipe) async {
  //   await _db.saveToMyRecipes(recipe);
  //   fetchRecipes();
  // }

  // void removeFromMyRecipes(Recipe recipe) {
  //   _db.removeFromMyRecipes(recipe);
  // }

  // Fetch recipe from API
  void fetchRandomRecipes() async {
    List<Recipe> recipes = await RecipeApi.getRandomRecipes();
    _randomRecipeList.addAll(recipes); // Add all fetched recipes to the list
    notifyListeners();
  }

  //recepten vi hämtar från API
  final List<Recipe> _randomRecipeList = [];

  List<Recipe> get randomRecipeList => _randomRecipeList;

// för att visa rätt RecipeInfo
  int recipeID = 656846;

  void chooseRecipeID(Recipe recipe) {
    recipeID = recipe.id;
    notifyListeners();
  }

  fetchIngredientsFromApi() async {
    notifyListeners();
    RecipeInfo recipeInfo = await RecipeApi.getIngredients(recipeID);
    print('${recipeInfo.toString()} fetchIngredientsFromApi done');
    _selectedRecipeInfo = recipeInfo;
    notifyListeners();
  }

  RecipeInfo? _selectedRecipeInfo;

  RecipeInfo? get selectedRecipeInfo => _selectedRecipeInfo;

  // Remove weird tokens from the instructions from api
  String removeHtmlTags(String htmlText) {
    // Check if the string contains the specific tokens
    if (!htmlText.contains('<ol>') || !htmlText.contains('<li>')) {
      return htmlText;
    }

    RegExp exp =
        RegExp(r"<li>(.*?)</li>", multiLine: true, caseSensitive: false);

    var matches = exp.allMatches(htmlText);
    StringBuffer sb = StringBuffer();

    int count = 1;
    for (var match in matches) {
      sb.write('$count. ${match.group(1)}\n');
      count++;
    }

    return sb.toString();
  }

  // Format diets for displaying in view recipes
  String formatDiets(String diets) {
    // Split the diets string based on comma (and possible space)
    List<String> dietList =
        diets.contains(', ') ? diets.split(', ') : diets.split(',');

    // Prepend a dot to each diet
    List<String> formattedDietList = dietList.map((diet) => '• $diet').toList();

    // Join them back with line breaks
    return formattedDietList.join('\n');
  }

  //recepten vi sparat
  List<Recipe> _myRecipeList = [];

  List<Recipe> get myRecipeList {
    return _myRecipeList;
  }

  //lägga till ett recept i _myRecipeList
  void addToMyRecipes(recipe) {
    _myRecipeList.add(recipe);
    notifyListeners();
  }

  void removeFromMyRecipes(recipe) {
    _myRecipeList.remove(recipe);
    notifyListeners();
  }

  String getImage(recipe) {
    return recipe.image;
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

//Mealplanner things
  void saveRecipeToMP(String chosenDay, Recipe chosenRecipe) {
    _plannerData[addPlannerItem(chosenDay, chosenRecipe)];
    notifyListeners();
  }

  final Map<String, Recipe?> _plannerData = {
    'Monday': null,
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

  //Tinder card functions
  //cardsAre used in homepage to see if there are cards to show or not
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
}

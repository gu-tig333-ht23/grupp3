// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/util/recipe_info.dart';
import '/util/api.dart';
import '/util/recipe.dart';
import 'db.dart';

class RecipeProvider extends ChangeNotifier {
  //DB
  final DB _db;
  RecipeProvider(DB db) : _db = db;

  //get recipes from DB
  void fetchRecipes() async {
    _myRecipeList = await _db.getRecipes();
    notifyListeners();
  }

  List<bool> checkboxStates = [];

  void setCheckboxState(int index, bool value) {
    checkboxStates[index] = value;
    notifyListeners();
  }

  void initializeCheckboxStates(int length) {
    checkboxStates = List.generate(length, (index) => false);
  }

  //recepten vi sparat
  List<Recipe> _myRecipeList = [];

  List<Recipe> get myRecipeList {
    return _myRecipeList;
  }

  //add recipes to DB & myRecipeList
  void addToMyRecipes(Recipe recipe) async {
    myRecipeList.add(recipe);
    await _db.saveToMyRecipes(recipe.id, recipe.title, recipe.image);
    fetchRecipes();
    notifyListeners();
  }

  //remove recipe from DB
  void removeFromMyRecipes(Recipe recipe) {
    _myRecipeList.remove(recipe);
    _db.removeFromMyRecipes(recipe);
    notifyListeners();
  }

  // Fetch recipe from API
  void fetchRandomRecipes() async {
    List<Recipe>? recipes = await RecipeApi.getRandomRecipes((message) {
      print(message);
    });
    _randomRecipeList.addAll(recipes); // Add all fetched recipes to the list
    notifyListeners();
  }

  //API recipes
  final List<Recipe> _randomRecipeList = [];
  List<Recipe> get randomRecipeList => _randomRecipeList;

// to show correct recipe info
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

  late RecipeInfo _selectedRecipeInfo;
  RecipeInfo get selectedRecipeInfo => _selectedRecipeInfo;

  String getFormattedIngredient(Map<String, String> ingredient) {
    final amount = ingredient['amount'];
    final unitShort = ingredient['unitShort'];

    return '$amount $unitShort';
  }

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

  checkIfNull(value,
      [String errMessage =
          'Sorry, we could not find this information for you']) {
    return value ?? errMessage;
  }

//MEALPLANNER THINGS
//select day to be able to send to addPlannerItem and so dropdown works
  String selectedDay = '';
  String selectTheDay(String weekday) {
    selectedDay = weekday;
    print('day is now $selectedDay');
    notifyListeners();
    return selectedDay;
  }

//local map where we store our mealplanner data
  Map<String, Recipe?> _plannerData = {
    'Monday': null,
    'Tuesday': null,
    'Wednesday': null,
    'Thursday': null,
    'Friday': null,
    'Saturday': null,
    'Sunday': null,
  };

  Map<String, Recipe?> get plannerData => _plannerData;

//add recipe to mealplan
  void addPlannerItem(String day, Recipe item) async {
    await _db.addPlannerItem(day, item);
    plannerData[day] = item;
    notifyListeners();
  }

//remove recipe from mealplan
  void removePlannerItem(String day) async {
    await _db.removePlannerItem(day);
    plannerData[day] = null;
    notifyListeners();
  }

// Fetch planner data and update local mealplan map.
  void fetchPlannerData() async {
    final data = await _db.getPlannerData();
    plannerData = data;
  }

  set plannerData(Map<String, Recipe?> data) {
    _plannerData = data;
    notifyListeners();
  }

//TINDER CARD FUNCTITONS
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

// ignore_for_file: constant_identifier_names, unnecessary_string_interpolations

import 'package:mealmate/util/recipe.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const String TABLE_RECIPES = 'recipes';
  static const String TABLE_PLANNER = 'mealplan';
  Database? _db;
  Recipe? recipeSaved;

//TO INITIALIZE DATABASE
  Future<void> init() async {
    var databasesPath = getDatabasesPath();
    var dbfilename = 'mealmate2.db';
    _db = await openDatabase(
      '$databasesPath/$dbfilename',

      //CREATE TABLES 1ST TIME EVER OPENING THE APP
      onCreate: (db, version) {
        //RECIPE TABLE
        db.execute('''CREATE TABLE $TABLE_RECIPES 
        (
          id INTEGER PRIMARY KEY,
          title TEXT,
          image TEXT
          )''');
        //MEALPLAN TABLE
        db.execute(''' CREATE TABLE $TABLE_PLANNER (
            day TEXT PRIMARY KEY,
            recipe_id INTEGER NULL,
            FOREIGN KEY (recipe_id) REFERENCES recipes(id)
          )
        ''');
        // To make sure mealplan table is not empty of days upon creation
        final weekdays = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ];
        //and we want each day to have no recipe
        for (var day in weekdays) {
          db.insert(TABLE_PLANNER, {
            'day': day,
            'recipe_id': null,
          });
        }
      },
      version: 1,
    );
  }

//RECIPE TABLE
//get recipes in a list
  Future<List<Recipe>> getRecipes() async {
    List<Map<String, dynamic>> results = await _db!.query(TABLE_RECIPES);
    print(results);
    return results.map((result) => Recipe.fromMap(result)).toList();
  }

//save recipies to database
  Future<void> saveToMyRecipes(int id, String title, String image) async {
    var recipe = Recipe(id: id, title: title, image: image);
    await _db!.insert(TABLE_RECIPES, recipe.toMap());
  }

//delete recipes from database
  Future<void> removeFromMyRecipes(Recipe recipe) async {
    await _db!.delete(TABLE_RECIPES, where: 'id = ?', whereArgs: [recipe.id]);
  }

//MEALPLAN TABLE
//add recipe to mealplan database
  Future<void> addPlannerItem(String day, Recipe item) async {
    final db = _db;
    if (db != null) {
      final existingRows =
          await db.query('$TABLE_PLANNER', where: 'day = ?', whereArgs: [day]);

      if (existingRows.isNotEmpty) {
        // Update the existing row with the new recipe
        await db.update(
            '$TABLE_PLANNER',
            {
              'recipe_id': item.id,
            },
            where: 'day = ?',
            whereArgs: [day]);
      } else {
        // Insert a new row for the day with the recipe (which shouldn't happen)
        await db.insert('$TABLE_PLANNER', {
          'day': day,
          'recipe_id': item.id,
        });
      }
    }
  }

//remove recipe from mealplan database
  Future<void> removePlannerItem(String day) async {
    final db = _db;
    await db?.update('$TABLE_PLANNER',
        {'recipe_id': null}, //set recipe to null, we don't want to delete row
        where: 'day = ?',
        whereArgs: [day]);
  }

//get mealplan data to be able to show in _plannerData in provider
  Future<Map<String, Recipe?>> getPlannerData() async {
    final db = _db;
    final result = await db!.query('$TABLE_PLANNER'); //what we have in DB
    final plannerData = Map<String, Recipe?>();

    for (var data in result) {
      final day = data['day'] as String;
      final recipeId = data['recipe_id'] as int?;

      if (recipeId != null) {
        final recipeResult = await db
            .query('$TABLE_RECIPES', where: 'id = ?', whereArgs: [recipeId]);

        if (recipeResult.isNotEmpty) {
          final recipe = Recipe.fromMap(recipeResult.first);
          plannerData[day] = recipe;
        } else {
          plannerData[day] = null;
        }
      } else {
        plannerData[day] = null;
      }
    }
    return plannerData;
  }
}

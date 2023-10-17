import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '/util/recipe.dart';
import '/util/recipe_info.dart';

const String ENDPOINTrandom =
    'https://api.spoonacular.com/recipes/complexSearch';
const String ENDPOINTing =
    'https://api.spoonacular.com/recipes/656846/information';
const String apiKey = 'd5d1ef4b65e24b1798f732f1798213da';

class RecipeApi {
  static Future<List<Recipe>> getRandomRecipes() async {
    Uri url = Uri.parse('$ENDPOINTrandom?sort=random&apiKey=$apiKey');

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipefromAPI = Recipe.fromMap(data['results'][0]);
      print(data); // prints out map of items from api correctly
      print(recipefromAPI.title);
      Recipe recipe = Recipe(
        id: recipefromAPI.id,
        title: recipefromAPI.title,
        image: recipefromAPI.image,
      );

      print(recipe.title);
      print(recipe.image);
      List<Recipe> recipes =
          data['results'].map<Recipe>((item) => Recipe.fromMap(item)).toList();
      return recipes;
    } catch (err) {
      throw err.toString();
    }
  }

  static Future<RecipeInfo> getIngredients() async {
    Uri url1 = Uri.parse('$ENDPOINTing?apiKey=$apiKey');
    /*final response =
        await http.get(url1, headers: {"Content-Type": "application/json"});*/

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(url1, headers: headers);
      Map<String, dynamic> obj = json.decode(response.body);

      // Extracting 'nameClean' from each 'extendedIngredients' item and collecting them into a list.
      List<String> ingredientNames = List<String>.from(
          obj['extendedIngredients'].map((obj) => obj['nameClean']));

      //RecipeInfo sum = RecipeInfo.fromMap(obj['summary']);
      //RecipeInfo timeCook = RecipeInfo.fromMap(obj['readyInMinutes']);
      RecipeInfo timeCook =
          RecipeInfo.fromMap({'readyInMinutes': obj['readyInMinutes']});
      RecipeInfo dietsFood = RecipeInfo.fromMap(obj['diets'][0]);
      RecipeInfo howTo = RecipeInfo.fromMap(obj['instructions']);

      RecipeInfo recipeInfo = RecipeInfo(
        ingredientsName: ingredientNames,
        //summary: sum.summary,
        cookTime: timeCook.cookTime,
        diets: dietsFood.diets,
        instructions: howTo.instructions,
      );

      /*RecipeInfo ingName = RecipeInfo.fromMap(
          obj['extendedIngredients'].map((obj) => obj['nameClean']));
      RecipeInfo sum = RecipeInfo.fromMap(obj['summary']);
      RecipeInfo timeCook = RecipeInfo.fromMap(obj['readyInMinutes']);
      RecipeInfo dietsFood = RecipeInfo.fromMap(obj['diets'][0]);
      RecipeInfo howTo = RecipeInfo.fromMap(obj['instructions']);

      RecipeInfo recipeInfo = RecipeInfo(
        ingredientsName: ingName.ingredientsName,
        summary: sum.summary,
        cookTime: timeCook.cookTime,
        diets: dietsFood.diets,
        instructions: howTo.instructions,
      );*/

      print(recipeInfo.ingredientsName);
      print(recipeInfo.cookTime);

      return recipeInfo;
    } catch (err) {
      throw err.toString();
    }
  }
}

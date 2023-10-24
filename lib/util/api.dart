// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '/util/recipe.dart';
import '/util/recipe_info.dart';

const String ENDPOINTrandom =
    'https://api.spoonacular.com/recipes/complexSearch';
const String ENDPOINTing = 'https://api.spoonacular.com/recipes';
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

      if (data['results'] == null || data['results'].isEmpty) {
        throw Exception('No recipes found in the API response.');
      }

      Recipe recipefromAPI = Recipe.fromMap(data['results'][0]);
      Recipe recipe = Recipe(
        id: recipefromAPI.id,
        title: recipefromAPI.title,
        image: recipefromAPI.image,
      );

      print(recipe.title);

      List<Recipe> recipes =
          data['results'].map<Recipe>((item) => Recipe.fromMap(item)).toList();
      return recipes;
    } catch (err) {
      throw err.toString();
    }
  }

  static Future<RecipeInfo> getIngredients(int recipeId) async {
    Uri url1 = Uri.parse('$ENDPOINTing/$recipeId/information?apiKey=$apiKey');

    print('hej vi har endpoint');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(url1, headers: headers);
    Map<String, dynamic> obj = json.decode(response.body);
    print('hej decode klart');

    List<String> ingredientsNames = [];

    if (obj['extendedIngredients'] != null) {
      ingredientsNames = (obj['extendedIngredients'] as List)
          .map((ingredient) => ingredient['nameClean'] as String? ?? "")
          .where((name) => name.isNotEmpty)
          .toList();
    }

    String diet =
        obj['diets'] != null && obj['diets'].isNotEmpty ? obj['diets'][0] : '';

    RecipeInfo recipeInfo = RecipeInfo(
      ingredientsName: ingredientsNames,
      cookTime: obj['readyInMinutes'] ?? 0,
      diets: diet,
      instructions: obj['instructions'] ?? '',
    );

    print('hej instansering klar.');

    return recipeInfo;
  }
}

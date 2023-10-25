// ignore_for_file: constant_identifier_names

//Emy f20028b02395416fbe1af1d72d9cb4ee
//Amanda d5d1ef4b65e24b1798f732f1798213da
//Agge e47fbe5acc954d6d8825bdecad67c254
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '/util/recipe.dart';
import '/util/recipe_info.dart';

const String ENDPOINTrandom =
    'https://api.spoonacular.com/recipes/complexSearch';
const String ENDPOINTing = 'https://api.spoonacular.com/recipes';
const String apiKey = 'e47fbe5acc954d6d8825bdecad67c254';

class RecipeApi {
  static Future<List<Recipe>> getRandomRecipes(
      void Function(String) snackis) async {
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
      if (err.toString().contains('API rate limit exceeded')) {
        // Display an error message for API rate limit exceeded
        snackis('API rate limit exceeded. Please try again later.');
      } else {
        // Handle other errors as needed
        print('Error: $err');
      }
      return []; // or throw the error further
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
    } else {
      print('error');
    }

    String diet =
        obj['diets'] != null && obj['diets'].isNotEmpty ? obj['diets'][0] : '';

    // Create a list to store ingredient details with metric unitShort and amount
    List<Map<String, String>> ingredientDetails =
        (obj['extendedIngredients'] as List).map((ingredient) {
      final metric = ingredient['measures']['metric'];
      return {
        'unitShort': metric['unitShort'] as String,
        'amount': metric['amount'].toString(),
      };
    }).toList();

    RecipeInfo recipeInfo = RecipeInfo(
      ingredientsName: ingredientsNames,
      cookTime: obj['readyInMinutes'] ?? 0,
      diets: diet,
      instructions: obj['instructions'] ?? '',
      // Include the ingredient details in the RecipeInfo
      ingredientDetails: ingredientDetails,
    );

    print('hej instansering klar.');

    return recipeInfo;
  }
}

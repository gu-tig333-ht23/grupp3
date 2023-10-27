// ignore_for_file: constant_identifier_names

//Emy f20028b02395416fbe1af1d72d9cb4ee
//Amanda d5d1ef4b65e24b1798f732f1798213da
//Agge e47fbe5acc954d6d8825bdecad67c254
//Lovisa 2f568241733441ca8901a6e839573ef8
//Rebecca 2ffc22b83a6b49dabcb750e6acaaa2fe
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '/util/recipe.dart';
import '/util/recipe_info.dart';

//url for random recipes
const String ENDPOINTrandom =
    'https://api.spoonacular.com/recipes/complexSearch';
//url for ingredients for a specific recipe
const String ENDPOINTing = 'https://api.spoonacular.com/recipes';
//our api key
const String apiKey = '2ffc22b83a6b49dabcb750e6acaaa2fe';

class RecipeApi {
  //GET RANDOM RECIPES
  static Future<List<Recipe>> getRandomRecipes() async {
    //url used to request random recipes from API
    Uri url = Uri.parse('$ENDPOINTrandom?sort=random&apiKey=$apiKey');
    //request will be using json data
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //what we get from url is stored in response
      var response = await http.get(url, headers: headers);
      //data is decoded response
      Map<String, dynamic> data = json.decode(response.body);

      //exception - no recipes found
      if (data['results'] == null || data['results'].isEmpty) {
        throw Exception('No recipes found in the API response.');
      }

      //creates recipe object from data
      Recipe recipefromAPI = Recipe.fromMap(data['results'][0]);
      Recipe recipe = Recipe(
        id: recipefromAPI.id,
        title: recipefromAPI.title,
        image: recipefromAPI.image,
      );

      print(recipe.title); //to check so that api works correctly

      //maps list of Recipe objects to be returned
      List<Recipe> recipes =
          data['results'].map<Recipe>((item) => Recipe.fromMap(item)).toList();
      return recipes;
    } catch (err) {
      throw err.toString(); //prints out error
    }
  }

  //GET RECIPE INGREDIENTS
  static Future<RecipeInfo> getIngredients(int recipeId) async {
    //url used to request recipe info from API for a specifc recipID
    Uri url1 = Uri.parse('$ENDPOINTing/$recipeId/information?apiKey=$apiKey');

    //request will be using json data
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    //what we get from url is stored in response
    var response = await http.get(url1, headers: headers);
    //data is decoded response
    Map<String, dynamic> obj = json.decode(response.body);

    List<String> ingredientsNames = [];
    //if data exists, extract ingredient names and store in list
    if (obj['extendedIngredients'] != null) {
      ingredientsNames = (obj['extendedIngredients'] as List)
          .map((ingredient) => ingredient['nameClean'] as String? ?? "")
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      print('error');
    }

    //check if diet is empty, if it is diets = '';
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

    //creates recipeInfo object from data to be returned
    RecipeInfo recipeInfo = RecipeInfo(
      ingredientsName: ingredientsNames,
      cookTime: obj['readyInMinutes'] ?? 0, //0 if it's empty
      diets: diet,
      instructions:
          obj['instructions'] ?? '', //empty string if no instructions available
      ingredientDetails: ingredientDetails,
    );

    return recipeInfo;
  }
}

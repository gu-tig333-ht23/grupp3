import 'dart:convert';
import 'package:http/http.dart' as http;
import '/util/recipe.dart';

const String ENDPOINT = 'https://api.spoonacular.com/recipes/complexSearch';
const String apiKey = 'f20028b02395416fbe1af1d72d9cb4ee';

// Class Recipe
// parametrar: id, title, image, readyinMinutes, dishTypes (lunch, dinner, etc), expectedIngridients (list)

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    Uri url = Uri.parse('$ENDPOINT?sort=random&apiKey=$apiKey');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['random']) {
      _temp.add(i["content"]["details"]);
    }
    return Recipe.recipesFromSnapshot(_temp);
  }

  // fetch recipes (GET)
  // parametrar: limitLicense, tags and number
  // parse into class

  // post recipes (store in my recipes - POST)

  // remove recipes (remove from storage - DELETE)
}

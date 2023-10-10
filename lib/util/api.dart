import 'dart:convert';
import 'package:http/http.dart' as http;

const String ENDPOINT = 'https://api.spoonacular.com/recipes/complexSearch';
const String apiKey = 'f20028b02395416fbe1af1d72d9cb4ee';

// Class Recipe
// parametrar: id, title, image, readyinMinutes, dishTypes (lunch, dinner, etc), expectedIngridients (list)

class Recipe {
  final double id;
  final String title;
  final String image;
  final int readyInMinutes;
  //final List<String> dishtypes;
  //final List expectedIngidients;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    //required this.dishtypes,
    //required this.expectedIngidients,
  });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      id: json['id'] as double,
      title: json['title'] as String,
      image: json['image'] as String,
      readyInMinutes: json['readyInMinutes'] as int,
      //dishtypes: (json['dishtypes'] as List <dynamic>).cast()<String>(),
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {title: $title, image: $image, readyinMinutes: $readyInMinutes}';
  }
}

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

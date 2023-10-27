class RecipeInfo {
  final List<String>
      ingredientsName; // the names of the ingredients used in the recipe.
  final int cookTime; // how long it takes to cook the recipe in minutes.
  final String
      diets; // the type of diet the recipe falls under (e.g., vegan, keto, etc.)
  final String instructions; // step-by-step instructions to cook the recipe.
  final List<Map<String, String>>
      ingredientDetails; // detailed info about each ingredient: its unit and amount.

  // Constructor for the class: this is how we create a new RecipeInfo object.
  RecipeInfo(
      {required this.ingredientsName,
      required this.cookTime,
      required this.diets,
      required this.instructions,
      required this.ingredientDetails});

  //takes a map and converts it to a RecipeInfo object.
  factory RecipeInfo.fromMap(Map<String, dynamic> data) {
    // Extract and clean ingredient names from the data.
    List<String> ingredientsNames = (data['extendedIngredients'] as List)
        .map((ingredient) => ingredient['nameClean'] as String)
        .toList();

    // Extract amount and measurement from each ingredient from the data.
    List<Map<String, String>> ingredientDetails =
        (data['extendedIngredients'] as List).map((ingredient) {
      final metric = ingredient['measures']['metric'];
      return {
        'unitShort': metric['unitShort'] as String,
        'amount': metric['amount'].toString(),
      };
    }).toList();

    // Returns a new RecipeInfo object using the extracted data.
    return RecipeInfo(
      ingredientsName: ingredientsNames,
      cookTime: data['readyInMinutes'] as int,
      diets: (data['diets'] as List).isEmpty ? '' : data['diets'][0] as String,
      instructions: data['instructions'] as String,
      ingredientDetails: ingredientDetails,
    );
  }
}

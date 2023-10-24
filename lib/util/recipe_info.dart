class RecipeInfo {
  final List<String> ingredientsName;
  final int cookTime;
  final String diets;
  final String instructions;

  RecipeInfo({
    required this.ingredientsName,
    required this.cookTime,
    required this.diets,
    required this.instructions,
  });

  factory RecipeInfo.fromMap(Map<String, dynamic> data) {
    List<String> ingredientsNames = (data['extendedIngredients'] as List)
        .map((ingredient) => ingredient['nameClean'] as String)
        .toList();

    return RecipeInfo(
      ingredientsName: ingredientsNames,
      cookTime: data['readyInMinutes'] as int,
      diets: (data['diets'] as List).isEmpty ? '' : data['diets'][0] as String,
      instructions: data['instructions'] as String,
    );
  }
}

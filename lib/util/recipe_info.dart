class RecipeInfo {
  //final Recipe recipe;
  final List<String> ingredientsName; //extendedIngredients - NameClean
  //final String summary; //summary
  final int cookTime; //readyInMinutes
  final String diets; //diets
  final String instructions; // instructions - steps - step

  RecipeInfo({
    //required this.recipe,
    required this.ingredientsName,
    //required this.summary,
    required this.cookTime,
    required this.diets,
    required this.instructions,
  });

  factory RecipeInfo.fromMap(Map<String, dynamic> map) {
    return RecipeInfo(
      ingredientsName: (map['extendedIngredients'] as List<dynamic>)
          .map((item) => item['nameClean'] as String)
          .toList(),
      //summary: map['summary'] as String,
      cookTime: map['readyInMinutes'] as int,
      diets: map['diets'][0] as String,
      instructions: (map['instructions'] as List<String>)
          .join('\n'), // Combining multiple steps into a single string
    );
  }

  /*static List<RecipeInfo> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return RecipeInfo.fromJson(data);
    }).toList();
  }*/

  //@override
  //String toString() {
  //return 'Recipe {title: $title, image: $image, readyinMinutes: $readyInMinutes}';
  //}
}

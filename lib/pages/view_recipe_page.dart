// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/recipe_info.dart';
import '../util/recipe_provider.dart';
import '/util/recipe.dart';

class ViewRecipePage extends StatelessWidget {
  final Recipe recipe;

  const ViewRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(204, 229, 134, 1.000),
        title: const Text(
          'RECIPE INFO',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset('lib/images/avo_icon.png'), //logo in corner
          ),
        ],
      ),
      body: ViewRecipe(recipe: recipe),
    );
  }
}

class ViewRecipe extends StatefulWidget {
  final Recipe recipe;

  const ViewRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  //function to format the text in diets & ingredient names.
  String capitalizeFirstLetterOfEachWord(String text) {
    return text
        .split(' ') //splits input text based on spaces
        .map((word) =>
            word[0].toUpperCase() +
            word.substring(1)) //to capitalize only the first letter
        .join(
            ' '); //rejoins modified words into single string using space as separator
  }

  @override
  void initState() {
    super.initState();
    final recipeProvider = context.read<RecipeProvider>();
    //context.read directly queries the context for the provider but returns null if it's not found.
    int ingredientCount = recipeProvider.selectedRecipeInfo.ingredientsName
        .length; //how many ingredients there are
    recipeProvider
        .initializeCheckboxStates(ingredientCount); //checkboxes are not checked
  }

  @override
  Widget build(BuildContext context) {
    RecipeInfo? recipeInfo = context.watch<RecipeProvider>().selectedRecipeInfo;
    final rp = Provider.of<RecipeProvider>(context);
    //Provider.of traverses the widget tree to find the provider but may throw an error if the provider is not available.

    return SingleChildScrollView(
      //to make page scrollable
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              //IMAGE
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Image.network(
                    widget.recipe.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              //TITLE
              Text(
                widget.recipe.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //COOKTIME
              Text(
                'Cook time: ${recipeInfo.cookTime} minutes',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          //DIET
          if (recipeInfo.diets.isNotEmpty) //only shows if there are diets
            ExpansionTile(
              title: const Text(
                'DIETS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      capitalizeFirstLetterOfEachWord(
                          rp.formatDiets(recipeInfo.diets)),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          //INGREDIENTS
          if (recipeInfo.ingredientsName.isNotEmpty)
            ExpansionTile(
              title: const Text(
                'INGREDIENTS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: <Widget>[
                ListView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), //Creates scroll physics that does not let the user scroll.
                  shrinkWrap:
                      true, //allows listview to be as tall as it's content
                  itemCount: recipeInfo.ingredientsName.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      //change checkboxes
                      leading: Checkbox(
                        value: rp.checkboxStates[index],
                        onChanged: (value) {
                          rp.setCheckboxState(index, value!);
                        },
                      ),
                      //ingredient names
                      title: Text(
                        capitalizeFirstLetterOfEachWord(
                            rp.checkIfNull(recipeInfo.ingredientsName[index])),
                      ),
                      //ingredient amounts
                      trailing: Text(
                        rp.getFormattedIngredient(recipeInfo.ingredientDetails[
                            index]), //provider formats ingredients in order
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ),
              ],
            ),
          //INSTRUCTIONS
          if (recipeInfo.instructions.isNotEmpty)
            ExpansionTile(
              title: const Text(
                'INSTRUCTIONS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      //provider checks if text is null and then removes ugly tags
                      rp.checkIfNull(
                        rp.removeHtmlTags(recipeInfo.instructions),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //so that end of text isn't covered up
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

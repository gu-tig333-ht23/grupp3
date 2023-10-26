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
  //for ingredients and diets
  String capitalizeFirstLetterOfEachWord(String text) {
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  void initState() {
    super.initState();
    final recipeProvider = context.read<RecipeProvider>();
    //to make checkboxes unchecked at first
    recipeProvider.initializeCheckboxStates(
        recipeProvider.selectedRecipeInfo.ingredientsName.length);
  }

  @override
  Widget build(BuildContext context) {
    RecipeInfo? recipeInfo = context.watch<RecipeProvider>().selectedRecipeInfo;
    final rp = Provider.of<RecipeProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
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
          //DIETS
          if (recipeInfo.diets.isNotEmpty)
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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recipeInfo.ingredientsName.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        value: rp.checkboxStates[index],
                        onChanged: (value) {
                          rp.setCheckboxState(index, value!);
                        },
                      ),
                      title: Text(
                        capitalizeFirstLetterOfEachWord(
                            rp.checkIfNull(recipeInfo.ingredientsName[index])),
                      ),
                      trailing: Text(
                        rp.getFormattedIngredient(
                            recipeInfo.ingredientDetails[index]),
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
          ExpansionTile(
            title: Text(
              'INGREDIENTS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
                      rp.checkIfNull(
                        rp.removeHtmlTags(recipeInfo.instructions),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //so that the last of the instructions don't get obscured
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

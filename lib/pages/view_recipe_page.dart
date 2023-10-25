// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/recipe_info.dart';
import '../util/recipe_provider.dart';
import '/util/recipe.dart';

class ViewRecipePage extends StatelessWidget {
  final Recipe recipe;
  ViewRecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        title: Text(
          'RECIPE INFO',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child:
                //logo in corner
                Image.asset('lib/images/avo_icon.png'),
          ),
        ],
      ),
      body: ViewRecipe(recipe: recipe),
    );
  }
}

class ViewRecipe extends StatelessWidget {
  const ViewRecipe({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    bool checkBoxChecked = false;
    RecipeInfo recipeInfo = context.watch<RecipeProvider>().selectedRecipeInfo;
    final rp = Provider.of<RecipeProvider>(context);
    return SingleChildScrollView(
      //so that the page is scrollable
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
                    recipe.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              //RECIPE TITLE
              Text(
                recipe.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //COOK TIME
              Text(
                'Cook time: ${recipeInfo.cookTime} minutes',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          //DIET
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (recipeInfo.diets.isNotEmpty) ...[
                  //so that the other recipe info still shows if there is no explicit diet
                  Text('DIETS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(rp.formatDiets(recipeInfo.diets),
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ],
            ),
          ),
          //INGREDIENTS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('INGREDIENTS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                      shrinkWrap: true, //makes it scrollable
                      itemCount: recipeInfo.ingredientsName.length,
                      itemBuilder: (context, index) {
                        var onChanged;
                        return ListTile(
                          //checkbox is not done yet if we want to be able to actually check the boxes
                          leading: Checkbox(
                              value: checkBoxChecked, onChanged: onChanged),
                          title: Text(recipeInfo.ingredientsName[index]),
                        );
                      }),
                )
              ],
            ),
          ),
          //INSTRUCTIONS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (recipeInfo.instructions.isNotEmpty) ...[
                  //so that the other recipe info still shows if there are no insructions
                  Text('INSTRUCTIONS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  //funcion from provider ensures there are no weird icons in instructions.
                  Text(rp.removeHtmlTags(recipeInfo.instructions)),
                ] else ...[
                  Text(
                    'INSTRUCTIONS NOT FOUND',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

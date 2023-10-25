// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/recipe_info.dart';
import '../util/recipe_provider.dart';
import '/util/recipe.dart';

class ViewRecipePage extends StatelessWidget {
  final Recipe recipe;

  ViewRecipePage({Key? key, required this.recipe}) : super(key: key);

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

  ViewRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  late List<bool> _checkboxStates;

  @override
  void initState() {
    super.initState();
    _checkboxStates = List.generate(
        context
                .read<RecipeProvider>()
                .selectedRecipeInfo
                .ingredientsName
                .length ??
            0,
        (index) => false);
  }

  String capitalizeFirstLetterOfEachWord(String text) {
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
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
              Text(
                widget.recipe.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cook time: ${recipeInfo.cookTime} minutes',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'DIETS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              if (recipeInfo.diets.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      capitalizeFirstLetterOfEachWord(
                          rp.formatDiets(recipeInfo.diets)),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
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
            children: <Widget>[
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipeInfo.ingredientsName.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _checkboxStates[index],
                      onChanged: (value) {
                        setState(() {
                          _checkboxStates[index] = value!;
                        });
                      },
                    ),
                    title: Text(
                      capitalizeFirstLetterOfEachWord(
                          rp.checkIfNull(recipeInfo.ingredientsName[index])),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
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
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

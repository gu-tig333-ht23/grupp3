// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/widgets/recipe_tile.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class MyRecipesPage extends StatelessWidget {
  const MyRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        title: const Text(
          'MY RECIPES',
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
      body: ViewMyRecipes(),
    );
  }
}

class ViewMyRecipes extends StatelessWidget {
  const ViewMyRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.recipeList.length,
        itemBuilder: (context, index) {
          return RecipeTile(
            recipe: value.recipeList[index],
          );
        },
      ),
    );
  }
}

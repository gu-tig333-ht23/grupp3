// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import '/pages/view_recipe_page.dart';
import '/util/recipe.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  RecipeTile({super.key, required this.recipe});

  void _showPopup(BuildContext context) {
    final pp = Provider.of<RecipeProvider>(context, listen: false);
    String selectedDay = pp.plannerData.keys.first;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('SELECT DAY'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 6, right: 6),
                    //DROPDOWN MENU
                    child: Consumer<RecipeProvider>(
                      builder: (context, value, child) => DropdownButton(
                        value: selectedDay,
                        items: value.plannerData.keys.map((String day) {
                          return DropdownMenuItem(
                            value: day,
                            child: Text(day),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedDay = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SAVE BUTTON
                      Consumer<RecipeProvider>(
                        builder: (context, value, child) => ElevatedButton(
                          onPressed: () {
                            pp.addPlannerItem(selectedDay, recipe);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      //CANCEL BUTTON
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.brown.withOpacity(0.5)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(2, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Column(
                children: [
                  //RECIPE TITLE
                  Text(
                    recipe.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  //VIEW RECIPE
                  Consumer<RecipeProvider>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () async {
                        //to set the recipe id correctly in provider
                        context.read<RecipeProvider>().chooseRecipeID(recipe);
                        //fetch ingredients from api
                        await context
                            .read<RecipeProvider>()
                            .fetchIngredientsFromApi();
                        //view recipe page
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewRecipePage(recipe: recipe);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'View recipe',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  //ADD RECIPE TO MEALPLAN
                  ElevatedButton.icon(
                    onPressed: () {
                      _showPopup(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      'Add to mealplan',
                      style: TextStyle(fontSize: 11, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            //REMOVE BUTTON PLACED ON TOP OF IMAGE
            Flexible(
              child: Stack(
                children: [
                  Container(
                    //IMAGE
                    width: 150,
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.brown,
                        image: DecorationImage(
                            image: NetworkImage(recipe.image),
                            fit: BoxFit.cover,
                            opacity: 0.7)),
                  ),
                  Positioned(
                    //REMOVE BUTTTON
                    right: 0,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<RecipeProvider>(context, listen: false)
                            .removeFromMyRecipes(recipe);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          minimumSize: Size(20, 20)),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

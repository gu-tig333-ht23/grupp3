// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

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
    //int chosenDay = pp.weekDays.values.first;
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
                              //chosenDay = value.weekDays[selectedDay] ?? 0;
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
                            print(
                                '$recipe is going to be saved to $selectedDay');
                            //print(chosenDay);
                            pp.saveRecipeToMP(selectedDay, recipe);
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
        padding: EdgeInsets.all(18),
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
            Column(
              children: [
                //RECIPE TITLE
                Text(
                  recipe.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${recipe.readyInMinutes} minutes',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),

                //VIEW RECIPE
                ElevatedButton(
                  onPressed: () {
                    //view recipe page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewRecipePage(recipe: recipe);
                        },
                      ),
                    );
                    print('view recipe clicked');
                  },
                  child: Text(
                    'View recipe',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),

                //ADD RECIPE TO MEALPLAN
                ElevatedButton.icon(
                  onPressed: () {
                    _showPopup(context);

                    //pop up window??
                    print('add to mealplan clicked');
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    'Add to mealplan',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  recipe.image,
                  width: 100,
                  height: 100,
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    //delete recipe from my saved recipes
                    Provider.of<RecipeProvider>(context, listen: false)
                        .removeFromMyRecipes(recipe);
                    print('delete clicked');
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
          //image
        ),
      ),
    );
  }
}

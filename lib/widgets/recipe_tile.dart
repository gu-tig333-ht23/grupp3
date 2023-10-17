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
                  // Text(
                  //   '${recipe.readyInMinutes} minutes',
                  //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  // ),

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
                    },
                    child: Text(
                      'View recipe',
                      style: TextStyle(fontSize: 12, color: Colors.black),
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
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            //image and close button
            Flexible(
              child: Stack(
                children: [
                  Container(
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

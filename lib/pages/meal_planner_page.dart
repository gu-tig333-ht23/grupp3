//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/recipe.dart';
import '../util/recipe_provider.dart';
import 'my_recipes_page.dart';
import 'view_recipe_page.dart';

//the page, bara appbar & scaffold
class MealPlannerPage extends StatelessWidget {
  const MealPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        title: const Text(
          'MEAL PLANNER',
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
      body: Column(
        children: [
          Expanded(
            child: ViewMealPlannerTile(),
          )
        ],
      ),
    );
  } //visa veckodagarna
}

//för att visa våra veckodagar
class ViewMealPlannerTile extends StatelessWidget {
  const ViewMealPlannerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
        builder: (context, value, child) => ListView.builder(
            itemCount: value.plannerData.length,
            itemBuilder: (context, index) {
              final dayOfWeek = value.plannerData.keys.elementAt(index);
              final recipe = value.plannerData[dayOfWeek];

              return recipe != null
                  ? MealPlannerTile(
                      dayOfWeek: dayOfWeek,
                      recipe: recipe,
                      isRecipeChosen: true,
                    )
                  : MealPlannerTile(
                      dayOfWeek: dayOfWeek,
                      recipe: recipe,
                      isRecipeChosen: false,
                    );
            }));
  }
}

//hur veckodag-tile ser ut. får inte riktigt den att justera vilket recept den visas
//tror detta behöver göras i en funktion i provider??
class MealPlannerTile extends StatelessWidget {
  String dayOfWeek;
  Recipe? recipe;
  bool isRecipeChosen;

  MealPlannerTile({
    super.key,
    required this.dayOfWeek,
    required this.recipe,
    required this.isRecipeChosen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(30),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //veckodagen
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  //rektangeln, dekoration
                  child: Container(
                    height: 25,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Color(0xffD89465),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                Text(
                  dayOfWeek,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 3),

            showRecipeOrNot(isRecipeChosen, dayOfWeek, recipe, context),
          ],
        ),
      ),
    );
  }
}

Widget showRecipeOrNot(bool isRecipeChosen, String dayOfWeek, Recipe? recipe,
    BuildContext context) {
  return isRecipeChosen
      //om recept finns??
      ? RecipieChosenMP(
          recipe: recipe,
          dayOfWeek: dayOfWeek,
        )
      //OM RECEPT EJ FINNS
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have not chosen a recipe for $dayOfWeek',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyRecipesPage()));
              },
              child: Text('Add recipe'),
            ),
          ],
        );
}

class RecipieChosenMP extends StatelessWidget {
  final String dayOfWeek;
  final Recipe? recipe;
  const RecipieChosenMP(
      {super.key, required this.recipe, required this.dayOfWeek});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.3,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.brown,
                    image: DecorationImage(
                      image: AssetImage(recipe!.image.toString()),
                      fit: BoxFit.cover,
                      opacity: 0.6,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      recipe!.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewRecipePage(recipe: recipe!);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<RecipeProvider>(context, listen: false)
                .removePlannerItem(dayOfWeek, recipe!);
          },
        ),
      ],
    );
  }
}

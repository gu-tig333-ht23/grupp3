//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/recipe_provider.dart';
import '../widgets/meal_planner_tile.dart';

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
        },
      ),
    );
  }
}

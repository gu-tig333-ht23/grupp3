import 'package:flutter/material.dart';

import '../../pages/home_page.dart';
import '../../pages/meal_planner_page.dart';
import '../../pages/my_recipes_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(204, 229, 134, 1.000),
        child: ListView(
          children: [
            //LOGO
            DrawerHeader(
                child: Image.asset(
              'lib/images/smaller_logo.png',
            )),
            //HOMEPAGE / DISCOVER RECIPES
            ListTile(
              leading: const Icon(Icons.image_search),
              title: const Text(
                'Discover Recipes',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .pop(MaterialPageRoute(builder: (context) => HomePage()));
                //.pop to not refresh the page, to stay on the most recent tinder card
              },
            ),
            //MEAL PLAN PAGE
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text(
                'Meal Plan',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MealPlannerPage()));
              },
            ),
            //MY SAVED RECIPES
            ListTile(
              leading: const Icon(Icons.cookie),
              title: const Text(
                'My Recipes',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyRecipesPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

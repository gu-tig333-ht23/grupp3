// ignore_for_file: prefer_const_constructors

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
//import 'package:mealmate/pages/grocerylist_page.dart';
import '/pages/meal_planner_page.dart';
import '/pages/my_recipes_page.dart';
//import 'package:mealmate/pages/pantry_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  List foodie = [
    'https://cdn-icons-png.flaticon.com/512/381/381007.png',
    'https://cdn-icons-png.flaticon.com/512/5402/5402052.png',
    'https://cdn-icons-png.flaticon.com/512/2503/2503814.png',
    'https://static.vecteezy.com/system/resources/previews/018/931/398/original/cartoon-avocado-icon-png.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        title: const Text(
          'M E A L M A T E',
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
      //navigation drawer
      drawer: drawerMethod(context),

      //swiper function, not finished
      body: AppinioSwiper(
          onSwipe: (index, direction) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.brown,
                content: Text(
                  'yay! you swiped somewhere!',
                  style: const TextStyle(fontSize: 16),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          loop: true,
          cardsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: double.infinity,
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.yellow[200],
                    image: DecorationImage(
                      image: NetworkImage(foodie[index]),
                      fit: BoxFit.fitWidth,
                    )),
              ),
            );
          },
          cardsCount: foodie.length),
    );
  }

  Drawer drawerMethod(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(204, 229, 134, 1.000),
        child: ListView(
          children: [
            DrawerHeader(
                child: Image.asset(
              'lib/images/smaller_logo.png',
            )),

            //homepage / discover recipes
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Discover Recipes',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            //meal plan
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text(
                'Meal Plan',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MealPlannerPage()));
              },
            ),
            //my saved recipes
            ListTile(
              leading: const Icon(Icons.cookie),
              title: const Text(
                'My Recipes',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyRecipesPage()));
              },
            ),
            /* unneccesary ATM
            //pantry
            ListTile(
              leading: const Icon(Icons.kitchen),
              title: const Text(
                'My Pantry',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PantryPage()));
              },
            ),
            //inköpslista
            ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text(
                'Grocerylist',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GrocerylistPage()));
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}

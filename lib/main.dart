//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/util/recipe_provider.dart';
import '/pages/intro_page.dart';
import 'package:provider/provider.dart';
import 'util/db.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //necessary for database
  //You only need to call this method if you need the binding to be initialized before calling [runApp].
  DB db = DB(); //create instance of DB class to be able to manage/use DB.
  await db
      .init(); //init initializes database. determines path where db files is stored and creates db.
  //await to ensure db is fully initialized before moving on.

  RecipeProvider state = RecipeProvider(db); //instance of provider

  state.fetchRecipes(); //fetch recipes from DB
  state.fetchRandomRecipes(); //fetch recipies from API when starting the app
  state.fetchPlannerData(); //fetch mealplan from DB

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove ugly banner
      title: 'MEALMATE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: IntroPage(),
    );
  }
}

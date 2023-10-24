//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/util/recipe_provider.dart';
import '/pages/intro_page.dart';
import 'package:provider/provider.dart';
import 'util/db.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DB db = DB();
  await db.init();

  RecipeProvider state = RecipeProvider();
  state.fetchRandomRecipes(); //fetch recipies from API when starting the app

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
      debugShowCheckedModeBanner: false,
      title: 'MEALMATE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        //textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: IntroPage(),
    );
  }
}

/*
FIXA:
my_recipes_page
- search bar?

 */
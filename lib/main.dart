//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/util/recipe_provider.dart';
import '/pages/intro_page.dart';
import 'package:provider/provider.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  RecipeProvider state = RecipeProvider();
  state.fetchRandomRecipes();
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
      title: 'Flutter Demo',
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
home_page
- refresh knapp när man har sett alla recept, då ska 10 nya visas
- filter?
my_recipes_page
- search bar?
- filter?
 */
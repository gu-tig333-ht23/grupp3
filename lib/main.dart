//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/util/recipe_provider.dart';
import '/pages/intro_page.dart';
import 'package:provider/provider.dart';

void main() {
  RecipeProvider state = RecipeProvider();
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
      ),
      home: IntroPage(),
    );
  }
}

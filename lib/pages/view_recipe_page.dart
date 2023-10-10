// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/util/recipe.dart';

class ViewRecipePage extends StatelessWidget {
  final Recipe recipe;
  const ViewRecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        title: Text(
          recipe.title,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Image.asset(
                    recipe.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Text(
                recipe.title,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '${recipe.readyInMinutes} minutes',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('INGREDIENTS', style: TextStyle(fontSize: 16)),
                Text('data'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('INSTRUCTIONS', style: TextStyle(fontSize: 16)),
                Text('data'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

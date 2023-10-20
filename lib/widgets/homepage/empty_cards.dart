import 'package:flutter/material.dart';
import '/pages/home_page.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class EmptyCards extends StatelessWidget {
  const EmptyCards({super.key});
  //THE USER IS OUT OF TINDERCARDS
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, value, child) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Column(children: [
                        const Text(
                          "We are out of recipes! Press the refresh button for more recipes.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 16),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          iconSize: 60,
                          color: Colors.green,
                          onPressed: () {
                            //FETCH NEW RANDOM RECIPES
                            Provider.of<RecipeProvider>(context, listen: false)
                                .fetchRandomRecipes();
                            //CLEAR LIST AND ADD NEW RECIPES
                            Provider.of<RecipeProvider>(context, listen: false)
                                .refreshCards(false);
                            //GO BACK TO HOMEPPAGE TO VIEW THE NEW CARDS
                            TinderOrEmptyWidget();
                          },
                        ),
                      ])),
                ),
                const SizedBox(height: 16),
                Image.asset('lib/images/avo_icon.png'),
              ],
            ),
          ),
        );
      },
    );
  }
}

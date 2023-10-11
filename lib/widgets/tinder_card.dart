// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors_in_immutables

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class TinderCard extends StatelessWidget {
  TinderCard({super.key});

  //kommer nog användas för att få knapparna att fungera med provider osv..
  //AppinioSwiperController _controller = AppinioSwiperController();

  void _swipe(int index, AppinioSwiperDirection direction) {
    if (direction.name == 'right') {
      //addToMyRecipes();
      //snackis('Recipe saved to My Recipes')
      print('you swiped right??');
    } else {
      //ska vi ha kod för när man swipar bort ngt??
      print('you swiped to the left');
    }
    //för att dubbelkolla så att det stämmer ovan bara
    print("the card was swiped to the: " + direction.name);
  }

  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<RecipeProvider>(context);

    return Consumer<RecipeProvider>(
      builder: (context, value, child) => AppinioSwiper(
        swipeOptions: AppinioSwipeOptions.only(left: true, right: true),
        onSwipe: (index, direction) {
          _swipe(index, direction);
        },
        loop: true,
        cardsBuilder: (context, index) {
          if (index >= 0 && index < value.randomRecipeList.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors
                          .white, //måste va vit, annars ser man igenom korten
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    value.randomRecipeList[index].image),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment(0, -0.5),
                              ),
                            ),
                          ),
                        ),
                        //RECIPE TITLE
                        Positioned(
                          bottom: 100,
                          left: 50,
                          right: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.brown.withOpacity(0.5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.brown.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      value.randomRecipeList[index].title,
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${value.randomRecipeList[index].readyInMinutes.toString()} minutes',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //ICON DELETE
                        Positioned(
                          left: 20,
                          bottom: 5,
                          child: IconButton(
                            icon:
                                Icon(Icons.close, size: 60, color: Colors.red),
                            onPressed: () {
                              print("X icon pressed");
                              //push away card somehow???
                            },
                          ),
                        ),
                        //ICON ADD
                        Positioned(
                          right: 20,
                          bottom: 5,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border_rounded,
                                size: 60, color: Colors.green),
                            onPressed: () {
                              //if(recipe does NOT exists in myRecipies){
                              rp.addToMyRecipes(value.randomRecipeList[index]);
                              //} else {snackis('this recipie is already saved')}
                              //snackis('Recipe saved to My Recipes')
                              print("Heart icon pressed");
                              //push away card somehow??
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('empty');
          }
        },
        cardsCount: value.randomRecipeList.length,
      ),
    );
  }
}

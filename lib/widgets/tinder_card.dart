// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import '/util/recipe_provider.dart';
import 'package:provider/provider.dart';

class TinderCard extends StatelessWidget {
  final AppinioSwiperController swipecontroller;
  TinderCard({required this.swipecontroller, super.key});

  @override
  Widget build(BuildContext context) {
    //SNACKBAR FUNCTION
    void snackis(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    return Consumer<RecipeProvider>(
      builder: (context, value, child) => AppinioSwiper(
        swipeOptions: AppinioSwipeOptions.only(left: true, right: true),
        controller: swipecontroller,
        onEnd: () {
          Provider.of<RecipeProvider>(context, listen: false)
              .cardsAreEmpty(true); //to show EmptyCards from HomePage
        },
        onSwipe: (index, direction) {
          _swipe(index, direction, value, snackis);
        },
        cardsCount: value.randomRecipeList.length,
        cardsBuilder: (context, index) {
          return Padding(
            //padding weird to make sure snackis doesn't cover buttons
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: 40.0),
            child: Stack(
              children: [
                //THE CARD
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
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
                      //IMAGE
                      Positioned.fill(
                        child: Container(
                          //image doesn't cover buttons
                          margin: EdgeInsets.only(bottom: 80.0),
                          decoration: BoxDecoration(
                            //rounded corners for image
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: Color.fromRGBO(204, 229, 134, 1.000),
                            image: DecorationImage(
                              //image from API
                              image: NetworkImage(
                                  value.randomRecipeList[index].image),
                              fit: BoxFit.cover,
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
                        //BACKGROUND BOX FOR TITLE
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
                          //TITLE
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    value.randomRecipeList[index].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //ICONS
                      Positioned.fill(
                        //to make sure icons on other cards doesn't show
                        bottom: 2,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //DELETE
                              IconButton(
                                icon: Icon(Icons.close,
                                    size: 60, color: Colors.red),
                                onPressed: () {
                                  swipecontroller.swipeLeft();
                                },
                              ),
                              //SAVE
                              IconButton(
                                icon: Icon(Icons.favorite_border_rounded,
                                    size: 60, color: Colors.green),
                                onPressed: () {
                                  swipecontroller.swipeRight();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //SWIPE FUNCTIONS
  void _swipe(int index, AppinioSwiperDirection direction, RecipeProvider value,
      void snackis(String text)) {
    index = index - 1;
    //ON SWIPE RIGHT
    if (direction.name == 'right' &&
        index >= 0 &&
        index <= value.randomRecipeList.length) {
      //IF RECIPE IS NOT ALREADY SAVED, SAVE RECIPE
      if (!value.myRecipeList.contains(value.randomRecipeList[index])) {
        value.addToMyRecipes(value.randomRecipeList[index]);
        snackis('Recipe saved!');
      } else {
        //RECIPE IS SAVED
        snackis('Recipe is already saved in My Recipes');
      }
    } else {
      //SWIPE LEFT: RECIPE IS PUSHED AWAY
    }
  }
}

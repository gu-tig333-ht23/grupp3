// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

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
      //recipeProvider.addToMyRecipes();
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
                      color: Colors.yellow[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
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
                        Positioned(
                          bottom: 100,
                          left: 50,
                          right: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  value.randomRecipeList[index].title,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 5,
                          child: IconButton(
                            icon:
                                Icon(Icons.close, size: 60, color: Colors.red),
                            onPressed: () {
                              print("X icon pressed");
                            },
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 5,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border_rounded,
                                size: 60, color: Colors.green),
                            onPressed: () {
                              rp.addToMyRecipes(value.randomRecipeList[index]);
                              //snackis('Recipe saved to My Recipes')
                              print("Heart icon pressed");
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
            return Container(
              child: Text('empty'),
            );
          }
        },
        cardsCount: value.randomRecipeList.length,
      ),
    );
  }
}

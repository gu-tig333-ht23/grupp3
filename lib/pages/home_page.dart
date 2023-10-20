// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/homepage/tinder_card.dart';
import 'package:provider/provider.dart';
import '../util/api.dart';
import '../util/recipe_provider.dart';
import '../widgets/homepage/empty_cards.dart';
import '../widgets/homepage/nav_drawer.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        centerTitle: true,
        title: Text(
          'M E A L M A T E',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.all(8),
              child:
                  //logo button, shows alert dialog with tutorial info
                  MaterialButton(
                onPressed: () {
                  _showTutorialDialog(context);
                },
                shape: CircleBorder(),
                minWidth: 0,
                height: 50,
                child: Image.asset('lib/images/avo_icon.png'),
              )),
        ],
      ),
      //navigation drawer
      drawer: NavDrawer(context: context),
      body: FutureBuilder(
        future: RecipeApi.getRandomRecipes(),
        builder: ((context, snapshot) {
          //SHOW DATA
          if (snapshot.connectionState == ConnectionState.done) {
            return TinderOrEmptyWidget();
          }
          //LOADING SCREEN
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            content: Text(
                "Hello!\n\nBegin by swiping on recipes. The recipes you like will be saved and can later be used to create a mealplan from.\n\nNavigate to different pages via the button in the top left corner."),
          ),
        );
      },
    );
  }
}

// Decides which body to be returned
class TinderOrEmptyWidget extends StatelessWidget {
  final AppinioSwiperController swipecontroller = AppinioSwiperController();

  TinderOrEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var rp = Provider.of<RecipeProvider>(context);

    if (rp.cardsAre == false) {
      return TinderCard(swipecontroller: swipecontroller);
    } else {
      return EmptyCards();
    }
  }
}

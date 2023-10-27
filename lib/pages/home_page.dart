// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/tinder_card.dart';
import 'package:provider/provider.dart';
import '../util/recipe_provider.dart';
import '../widgets/empty_cards.dart';
import '../widgets/nav_drawer.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(204, 229, 134, 1.000),
        centerTitle: true,
        title: const Text(
          'M E A L M A T E',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8),
              child:
                  //logo button, shows alert dialog with tutorial info
                  MaterialButton(
                onPressed: () {
                  _showTutorialDialog(context);
                },
                shape: const CircleBorder(),
                minWidth: 0,
                height: 50,
                child: Image.asset('lib/images/avo_icon.png'),
              )),
        ],
      ),
      //navigation drawer
      drawer: NavDrawer(context: context),
      //tinder cards or refresh page
      body: TinderOrEmptyWidget(),
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: const AlertDialog(
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
  //swipecontroller is sent to TinderCard();
  final AppinioSwiperController swipecontroller = AppinioSwiperController();

  TinderOrEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var rp = Provider.of<RecipeProvider>(context);

    if (rp.cardsAre == false) {
      //if cards are not empty, show cards
      return TinderCard(swipecontroller: swipecontroller);
    } else {
      return const EmptyCards(); //cards are empty
    }
  }
}

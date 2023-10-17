// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mealmate/widgets/tinder_card.dart';
import 'package:provider/provider.dart';
import '../util/recipe_provider.dart';
import '../widgets/empty_cards.dart';
import '../widgets/nav_drawer.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

//ÄR NOG ANVÄNDBART FÖR ATT VISA DET VI HÄMTAT FRÅN API, LADD SKÄRM
/*//SHOW LIST IN HOMEPAGE
      body: FutureBuilder(
        future: API.getList(),
        builder: ((context, snapshot) {
          //SHOW DATA
          if (snapshot.connectionState == ConnectionState.done) {
            return const ViewMyList();
          }
          //LOADING SCREEN
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ), 
*/

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
                  //logo in corner
                  MaterialButton(
                onPressed: () {},
                shape: CircleBorder(),
                minWidth: 0, // Set minWidth to 0 to make it circular
                height: 50, // Adjust height as needed
                child: Image.asset('lib/images/avo_icon.png'),
              )
              //Image.asset('lib/images/avo_icon.png'),
              ),
        ],
      ),
      //navigation drawer
      drawer: NavDrawer(context: context),
      body: TinderOrEmptyWidget(),
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

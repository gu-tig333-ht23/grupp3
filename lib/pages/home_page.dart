// ignore_for_file: prefer_const_constructors

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_drawer.dart';

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
  HomePage({super.key});

  //ranom "recipes" in a list that shows up in the tindercards.
  List foodie = [
    'https://cdn-icons-png.flaticon.com/512/381/381007.png',
    'https://cdn-icons-png.flaticon.com/512/5402/5402052.png',
    'https://cdn-icons-png.flaticon.com/512/2503/2503814.png',
    'https://static.vecteezy.com/system/resources/previews/018/931/398/original/cartoon-avocado-icon-png.png',
  ];
  //kommer nog användas för att få knapparna att fungera med provider osv..
  //AppinioSwiperController _controller = AppinioSwiperController();

  void _swipe(int index, AppinioSwiperDirection direction) {
    if (direction.name == 'right') {
      //addToMyRecipes()
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        centerTitle: true,
        title: Text(
          'M E A L M A T E',
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
      //navigation drawer
      drawer: NavDrawer(context: context),
      body: AppinioSwiper(
        swipeOptions: AppinioSwipeOptions.only(left: true, right: true),
        onSwipe: (index, direction) {
          _swipe(index, direction);
        },
        loop: true,
        cardsBuilder: (context, index) {
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
                              image: NetworkImage(foodie[index]),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment(0, -0.5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 5,
                        child: IconButton(
                          icon: Icon(Icons.close, size: 60, color: Colors.red),
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
                            //addToMyRecipes()
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
        },
        cardsCount: foodie.length,
      ),
    );
  }

  void snackis(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.brown,
        content: Text(
          'yay! you swiped right!',
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

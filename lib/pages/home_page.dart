// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mealmate/widgets/tinder_card.dart';
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
      body: TinderCard(),
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/pages/home_page.dart';

//vi sa väl att denna sida bara skulle visas i ca 5 sekunder,
//tänker väl att vi kan säkert bygga in en att den laddar tills
//vi har hämtat data men minst 5s.
//
//följande kod är från to-do-app som på homescreen visar progressindicator
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

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 50),

//icon
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              'lib/images/bigger_logo.png',
            ),
          ),

          const SizedBox(height: 50),

//title
          Text(
            'YOUR MEAL PLANNER',
            style: TextStyle(
              fontSize: 44,
              color: Color.fromRGBO(138, 53, 46, 1.000),
            ),
            /*style: GoogleFonts.dmSerifDisplay(
              fontSize: 44,
              color: Color.fromRGBO(138, 53, 46, 1.000),
            ),*/
          ),
          const SizedBox(height: 10),
//subtitle
          const Text(
            'Everything you need to plan meals for the week, keep track of items in your pantry, and what you need to shop.',
            style: TextStyle(
              fontSize: 16,
              height: 2,
              color: Color.fromRGBO(138, 53, 46, 1.000),
            ),
          ),
          const SizedBox(height: 50),

//button
          MaterialButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            color: const Color.fromRGBO(138, 53, 46, 1.000),
            textColor: Colors.white,
            child: const Text('Get started'),
          ),
        ]),
      ),
    );
  }
}

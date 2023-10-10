//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MealPlannerPage extends StatelessWidget {
  const MealPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
        title: const Text(
          'MEAL PLANNER',
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
      body: Padding(
        padding:
            EdgeInsets.all(20), //mellanrum runt boxarna //gjorde lite mindre /E
        child: Column(
          children: [
            Expanded(
              child: buildSubjects(),
            )
          ],
        ),
      ),
    );
  } //visa veckodagarna

  Widget buildSubjects() {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final dayOfWeek = getDayOffWeek(index);
          return Column(
            children: [
              buildSubject(dayOfWeek),
              SizedBox(
                height: 18,
              ),
            ],
          );
        });
  }

//lista med veckodagarna
  String getDayOffWeek(int index) {
    final daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return daysOfWeek[index];
  }

// boxarna för alla dagar, bakgrunden
  Widget buildSubject(String dayOfWeek) {
    return Container(
      //ändrade så att det inte blir dubbel padding mellan tiles /E
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          //ändrade till brown, vad tycker vi? /E
          color: Colors.brown,
        ),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            //ändrade till brown & minimerade skuggan, vad tycker vi? /E
            color: Colors.brown.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(2, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //veckodagen
          Center(
            child: Text(
              dayOfWeek,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                //ända jag hittade inom textstyle för att fixa bakgrundsfärgen /E
                //backgroundColor: Colors.deepOrange[200],
              ),
            ),
          ),

          const SizedBox(height: 4), //minimerade för jämnhet /E
          //bilden
          Center(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      //rundade hörn
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'lib/images/meal.png',
                        //ändrade så att bilden är lite större /E
                        width: 200,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),

                //tabort-ikonen
                Positioned(
                  //right & top kan tas bort om vi är nöjda med positionen av knappen /E
                  //right: 0,
                  top: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white,
                      width: 50, //den va väldigt stor innan /E
                      height: 50,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.black,
                          onPressed: () {
                            //SEPARAT funktion förmodligen
                            //image/recipe is removed
                            //drop down menu appears
                            //choose new recipe
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

//navigator.pop twice to go back to homepage via nav drawer
void popTwice(BuildContext context) {
  int count = 0;
  Navigator.popUntil(context, (route) {
    return count++ == 2;
  });
}

class NoSavedRecipes extends StatelessWidget {
  const NoSavedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //IMAGE
            Image.asset('lib/images/avo_icon.png'),
            const SizedBox(height: 16),
            //TEXT
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "You have not saved any recipes, go swipe away!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
            const SizedBox(height: 50),
            //BUTTON back to discover recipes / homepage
            ElevatedButton.icon(
              onPressed: () {
                popTwice(context);
              },
              icon: const Icon(Icons.image_search),
              label: const Text(
                'Discover recipes',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

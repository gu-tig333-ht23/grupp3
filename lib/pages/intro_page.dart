import 'package:flutter/material.dart';
import '/pages/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePageAfterDelay();
  }

  //automatic navigation to HomePage after 3 seconds
  _navigateToHomePageAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(204, 229, 134, 1.000),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Image.asset(
            'lib/images/bigger_logo.png',
          ),
        ),
      ),
    );
  }
}

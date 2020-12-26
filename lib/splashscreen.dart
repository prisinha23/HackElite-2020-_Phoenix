import 'dart:async';
import 'package:hack_athon/welcome.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              child: Lottie.asset('lottie/splash.json'),
              padding: const EdgeInsets.all(10.0),
            ),
            Text(
              "Get Your Vaccine Now",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico"),
            ),
            Text("You Stay We Work",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lobster"))
          ],
        ),
      ),
    );
  }
}

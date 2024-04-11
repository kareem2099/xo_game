import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'player_page.dart'; // Import PlayerPage

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to PlayerPage after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PlayerPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/Animation - 1712833907034.json',
          width: 200, // Adjust size as needed
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

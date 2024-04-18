import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xo_game/modules/game_selection_game.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to PlayerPage after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GameModeSelectionPage()),
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

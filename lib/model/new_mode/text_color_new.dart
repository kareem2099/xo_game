import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo_game/model/new_mode/new_mode.dart'; // Make sure to import GoogleFonts

class TextColorNewScreen extends StatefulWidget {
  const TextColorNewScreen({super.key});
  @override
  State<TextColorNewScreen> createState() => _TextColorNewScreenState();
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

class _TextColorNewScreenState extends State<TextColorNewScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 14), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NewModePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NewModePage()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Add horizontal padding
          alignment:
              Alignment.center, // Center the text vertically and horizontally
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'welcome to',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'new generation of',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'xo game with new',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'game style',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

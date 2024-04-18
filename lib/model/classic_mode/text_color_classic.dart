import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'classic_mode.dart';

class TextColorClassicScreen extends StatefulWidget {
  const TextColorClassicScreen({super.key});
  @override
  State<TextColorClassicScreen> createState() => _TextColorClassicScreenState();
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

class _TextColorClassicScreenState extends State<TextColorClassicScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ClassicModePage()),
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
            MaterialPageRoute(builder: (context) => const ClassicModePage()),
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
                    'xo game with',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    '3 enjoyable modes',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'choose your mode:',
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

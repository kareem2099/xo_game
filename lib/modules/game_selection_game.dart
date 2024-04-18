import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:xo_game/model/classic_mode/text_color_classic.dart';
import 'package:xo_game/model/new_mode/text_color_new.dart';

class GameModeSelectionPage extends StatelessWidget {
  const GameModeSelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Game Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedButton.strip(
              width: 200,
              height: 70,
              text: 'Classic Mode',
              isReverse: true,
              selectedTextColor: Colors.black,
              stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
              selectedBackgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 28,
                letterSpacing: 5,
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TextColorClassicScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            AnimatedButton.strip(
              width: 200,
              height: 70,
              text: 'New Mode',
              isReverse: true,
              selectedTextColor: Colors.black,
              stripTransitionType: StripTransitionType.LEFT_TO_RIGHT,
              selectedBackgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 28,
                letterSpacing: 5,
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TextColorNewScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'classic_hard_mode.dart';
import 'classic_easy_mode.dart';
import 'classic_medium_mode.dart';

class ClassicModePage extends StatefulWidget {
  const ClassicModePage({super.key});

  @override
  State<ClassicModePage> createState() => _ClassicModePageState();
}

class _ClassicModePageState extends State<ClassicModePage> {
  void navigateToDifficulty(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClassicEasyModePage()),
        );
        break;
      case 'Medium':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ClassicMediumModePage()),
        );
        break;
      case 'Hard':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClassicHardModePage()),
        );
        break;
      default:
        // Handle unknown difficulty
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Difficulty'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          DifficultyCard(
            title: 'Easy',
            imagePath:
                'assets/babyxo.png', // Replace with your actual image path
            onTap: () => navigateToDifficulty('Easy'),
          ),
          DifficultyCard(
            title: 'Medium',
            imagePath:
                'assets/mediumxo.png', // Replace with your actual image path
            onTap: () => navigateToDifficulty('Medium'),
          ),
          DifficultyCard(
            title: 'Hard',
            imagePath:
                'assets/hardxo.png', // Replace with your actual image path
            onTap: () => navigateToDifficulty('Hard'),
          ),
        ],
      ),
    );
  }
}

class DifficultyCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const DifficultyCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(imagePath, fit: BoxFit.cover),
            ListTile(
              title: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:xo_game/model/classic_mode/game_page_hard.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ClassicHardModePage extends StatefulWidget {
  const ClassicHardModePage({super.key});

  @override
  State<ClassicHardModePage> createState() => _ClassicHardModePageState();
}

class _ClassicHardModePageState extends State<ClassicHardModePage> {
  TextEditingController player1NameController = TextEditingController();
  TextEditingController player2NameController = TextEditingController();
  Color player1Color = Colors.blue; // Default colors
  Color player2Color = Colors.red;

  @override
  void dispose() {
    player1NameController.dispose();
    player2NameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard mode'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: player1NameController,
                decoration: const InputDecoration(
                  labelText: 'Player 1 Name',
                ),
              ),
              const SizedBox(height: 20),
              buildColorPicker(context, 'Player 1 Color', player1Color,
                  (color) {
                setState(() {
                  player1Color = color;
                });
              }),
              const SizedBox(height: 20),
              TextField(
                controller: player2NameController,
                decoration: const InputDecoration(
                  labelText: 'Player 2 Name',
                ),
              ),
              const SizedBox(height: 20),
              buildColorPicker(context, 'Player 2 Color', player2Color,
                  (color) {
                setState(() {
                  player2Color = color;
                });
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String player1Name = player1NameController.text;
                  String player2Name = player2NameController.text;
                  if (player1Name.isNotEmpty && player2Name.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePageHard(
                          player1Name: player1Name,
                          player2Name: player2Name,
                          player1Color: player1Color,
                          player2Color: player2Color,
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Please enter names for both players.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Start Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker(BuildContext context, String title,
      Color currentColor, Function(Color) onColorChanged) {
    return CircleAvatar(
      backgroundColor: currentColor,
      child: IconButton(
        icon: const Icon(Icons.color_lens),
        onPressed: () async {
          Color? selectedColor = await showDialog<Color>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: currentColor,
                    onColorChanged: onColorChanged,
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: true,
                    displayThumbColor: true,
                    labelTypes: const [],
                    paletteType: PaletteType.hsv,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(currentColor);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          if (selectedColor != null) {
            onColorChanged(selectedColor);
          }
        },
      ),
    );
  }
}
